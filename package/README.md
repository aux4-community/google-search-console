# community/google-search-console

Commands to interact with Google Search Console using the Search Console API

This package provides aux4 command wrappers for the [Google Search Console API](https://developers.google.com/webmaster-tools/v1/api_reference_index). It covers querying search analytics data (clicks, impressions, CTR, position), inspecting URL index status, requesting indexing, managing verified sites, and managing sitemaps.

Authentication is handled by [community/google-auth](https://hub.aux4.io/package/community/google-auth), which stores a single OAuth2 token shared by every aux4 Google package.

## Installation

```bash
aux4 aux4 pkger install community/google-search-console
```

## System Dependencies

This package requires:

- **jq** — for percent-encoding site and sitemap URLs into API path segments
  - [brew](https://brew.sh): `brew install jq`
  - linux: `apt install jq`

## Prerequisites

Authenticate once with `community/google-auth`. The scopes are resolved from the
installed Google service packages, so no `--scopes` flag is needed:

```bash
aux4 google auth login
```

This package requests:

- `https://www.googleapis.com/auth/webmasters` — read and write Search Console data
- `https://www.googleapis.com/auth/indexing` — publish URL notifications to the Indexing API

To request read-only access instead, log in with `--readonly true`. This package then
asks for `https://www.googleapis.com/auth/webmasters.readonly` only, which means
`sites add`, `sites delete`, `sitemaps submit`, `sitemaps delete` and `index` will be
rejected by Google:

```bash
aux4 google auth login --readonly true
```

Check the current state at any time:

```bash
aux4 google auth status
```

## Quick Start

List your verified sites:

```bash
aux4 google search-console sites list
```

Query search performance for the last month:

```bash
aux4 google search-console query example.com --startDate 2024-01-01 --endDate 2024-01-31
```

Inspect a URL's index status:

```bash
aux4 google search-console inspect https://example.com/page --siteUrl example.com
```

## Search Analytics — query performance data

### Basic query

Get aggregate clicks, impressions, CTR, and position:

```bash
aux4 google search-console query example.com --startDate 2024-01-01 --endDate 2024-01-31
```

### Group by dimensions

Get top search queries:

```bash
aux4 google search-console query example.com --startDate 2024-01-01 --endDate 2024-01-31 --dimensions query --rowLimit 50
```

Get performance by page:

```bash
aux4 google search-console query example.com --startDate 2024-01-01 --endDate 2024-01-31 --dimensions page
```

Get daily trend:

```bash
aux4 google search-console query example.com --startDate 2024-01-01 --endDate 2024-01-31 --dimensions date
```

Combine dimensions:

```bash
aux4 google search-console query example.com --startDate 2024-01-01 --endDate 2024-01-31 --dimensions query,page,country
```

### Available dimensions

- `query` — search terms users typed
- `page` — the URL that appeared in results
- `country` — country of the user (ISO 3166-1 alpha-3)
- `device` — device type: DESKTOP, MOBILE, TABLET
- `searchAppearance` — special search result features
- `date` — date of the search

### Filter by search type

```bash
aux4 google search-console query example.com --startDate 2024-01-01 --endDate 2024-01-31 --searchType image
```

Supported types: `web` (default), `image`, `video`, `news`, `discover`, `googleNews`

### Pagination

Results are limited to 1000 rows by default (max 25000). Use `--startRow` to paginate:

```bash
aux4 google search-console query example.com --startDate 2024-01-01 --endDate 2024-01-31 --dimensions query --rowLimit 1000 --startRow 0
aux4 google search-console query example.com --startDate 2024-01-01 --endDate 2024-01-31 --dimensions query --rowLimit 1000 --startRow 1000
```

## URL Inspection

Inspect a URL's index status and crawl information:

```bash
aux4 google search-console inspect https://example.com/page --siteUrl example.com
```

Returns index status, crawl time, robots.txt state, and whether the page is indexed.

## Indexing — request a crawl

Ask Google to crawl a new or updated URL:

```bash
aux4 google search-console index https://example.com/page
```

Tell Google a URL is gone:

```bash
aux4 google search-console index https://example.com/removed --type URL_DELETED
```

**Note:** the Indexing API is write-only and has no read-only equivalent scope, so this command does not work after `aux4 google auth login --readonly true`.

## Sites — manage verified properties

### List all sites

```bash
aux4 google search-console sites list
```

### Get site info

```bash
aux4 google search-console sites get example.com
```

### Add a site

```bash
aux4 google search-console sites add example.com
```

### Remove a site

```bash
aux4 google search-console sites delete example.com
```

## Sitemaps — manage submitted sitemaps

### List sitemaps

```bash
aux4 google search-console sitemaps list example.com
```

### Get sitemap details

```bash
aux4 google search-console sitemaps get --siteUrl example.com --feedpath https://example.com/sitemap.xml
```

### Submit a sitemap

```bash
aux4 google search-console sitemaps submit --siteUrl example.com --feedpath https://example.com/sitemap.xml
```

### Delete a sitemap

```bash
aux4 google search-console sitemaps delete --siteUrl example.com --feedpath https://example.com/sitemap.xml
```

**Note:** `sitemaps get`, `submit` and `delete` take two values, so pass them as the named flags `--siteUrl` and `--feedpath` rather than as bare positional arguments.

## Site URL Formats

You can pass the site URL in any of these formats -- domain properties are auto-detected:

- **Plain domain**: `example.com` — auto-detected as `sc-domain:example.com`
- **Explicit domain property**: `sc-domain:example.com` — used as-is
- **URL-prefix property**: `https://example.com` — used as-is

All three formats are accepted by every command that takes a `siteUrl` argument, and are percent-encoded into the API path automatically.

## Environment Variables

- `AUX4_GOOGLE_TOKEN_FILE` — where the shared Google OAuth token lives. Defaults to `~/.aux4.config/.oauth/google.json`, the same location `aux4 google auth login` writes to, so it normally needs no setting.

For the optional `integration` test group, set:

- `SEARCH_CONSOLE_SITE_URL` — your verified site URL
- `SEARCH_CONSOLE_START_DATE` — test date range start (YYYY-MM-DD)
- `SEARCH_CONSOLE_END_DATE` — test date range end (YYYY-MM-DD)

## License

MIT — See [LICENSE](./LICENSE) for details.
