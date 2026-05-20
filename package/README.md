# community/google-search-console

Commands to interact with Google Search Console using the Search Console API

This package provides aux4 command wrappers for the [Google Search Console API](https://developers.google.com/webmaster-tools/v1/api_reference_index). It covers querying search analytics data (clicks, impressions, CTR, position), inspecting URL index status, managing verified sites, and managing sitemaps.

Authentication is handled through the Google Workspace CLI (`gws`) with custom OAuth scopes — the same credential store used by other Google packages (Sheets, Drive, etc.).

## Installation

```bash
aux4 aux4 pkger install community/google-search-console
```

## System Dependencies

This package requires:

- **Google Workspace CLI** (`gws`) — for authentication and credential management
  - [brew](https://brew.sh): `brew install googleworkspace-cli`
  - [npm](https://www.npmjs.com): `npm install -g @googleworkspace/cli`
- **jq** — for JSON processing
  - [brew](https://brew.sh): `brew install jq`

## Prerequisites

Authenticate with Search Console scopes (read-only):

```bash
aux4 google auth login --scopes https://www.googleapis.com/auth/webmasters.readonly
```

For write access (add/delete sites, submit/delete sitemaps):

```bash
aux4 google auth login --scopes https://www.googleapis.com/auth/webmasters
```

You can combine Search Console scopes with other Google services in a single login:

```bash
aux4 google auth login --services sheets,drive --scopes https://www.googleapis.com/auth/webmasters.readonly
```

## Quick Start

List your verified sites:

```bash
aux4 google search-console sites list
```

Query search performance for the last month:

```bash
aux4 google search-console query https://example.com --startDate 2024-01-01 --endDate 2024-01-31
```

Inspect a URL's index status:

```bash
aux4 google search-console inspect https://example.com/page --siteUrl https://example.com
```

## Search Analytics — query performance data

### Basic query

Get aggregate clicks, impressions, CTR, and position:

```bash
aux4 google search-console query https://example.com --startDate 2024-01-01 --endDate 2024-01-31
```

### Group by dimensions

Get top search queries:

```bash
aux4 google search-console query https://example.com --startDate 2024-01-01 --endDate 2024-01-31 --dimensions query --rowLimit 50
```

Get performance by page:

```bash
aux4 google search-console query https://example.com --startDate 2024-01-01 --endDate 2024-01-31 --dimensions page
```

Get daily trend:

```bash
aux4 google search-console query https://example.com --startDate 2024-01-01 --endDate 2024-01-31 --dimensions date
```

Combine dimensions:

```bash
aux4 google search-console query https://example.com --startDate 2024-01-01 --endDate 2024-01-31 --dimensions query,page,country
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
aux4 google search-console query https://example.com --startDate 2024-01-01 --endDate 2024-01-31 --searchType image
```

Supported types: `web` (default), `image`, `video`, `news`, `discover`, `googleNews`

### Pagination

Results are limited to 1000 rows by default (max 25000). Use `--startRow` to paginate:

```bash
aux4 google search-console query https://example.com --startDate 2024-01-01 --endDate 2024-01-31 --dimensions query --rowLimit 1000 --startRow 0
aux4 google search-console query https://example.com --startDate 2024-01-01 --endDate 2024-01-31 --dimensions query --rowLimit 1000 --startRow 1000
```

## URL Inspection

Inspect a URL's index status and crawl information:

```bash
aux4 google search-console inspect https://example.com/page --siteUrl https://example.com
```

Returns index status, crawl time, robots.txt state, and whether the page is indexed.

## Sites — manage verified properties

### List all sites

```bash
aux4 google search-console sites list
```

### Get site info

```bash
aux4 google search-console sites get https://example.com
```

### Add a site

```bash
aux4 google search-console sites add https://example.com
```

### Remove a site

```bash
aux4 google search-console sites delete https://example.com
```

## Sitemaps — manage submitted sitemaps

### List sitemaps

```bash
aux4 google search-console sitemaps list https://example.com
```

### Get sitemap details

```bash
aux4 google search-console sitemaps get https://example.com https://example.com/sitemap.xml
```

### Submit a sitemap

```bash
aux4 google search-console sitemaps submit https://example.com https://example.com/sitemap.xml
```

### Delete a sitemap

```bash
aux4 google search-console sitemaps delete https://example.com https://example.com/sitemap.xml
```

## Site URL Formats

Search Console supports two site URL formats:

- **URL-prefix property**: `https://example.com` — covers only that specific URL prefix
- **Domain property**: `sc-domain:example.com` — covers all URLs under the domain

Use the same format as shown in your Search Console property list.

## Environment Variables

Authentication uses the same credential store as the Google Workspace CLI:

- `GOOGLE_WORKSPACE_CLI_TOKEN` — Pre-obtained OAuth2 access token (highest priority)
- `GOOGLE_WORKSPACE_CLI_CREDENTIALS_FILE` — Path to credentials JSON file
- `GOOGLE_WORKSPACE_CLI_CONFIG_DIR` — Override default config directory

For tests, set:
- `SEARCH_CONSOLE_SITE_URL` — your verified site URL
- `SEARCH_CONSOLE_START_DATE` — test date range start (YYYY-MM-DD)
- `SEARCH_CONSOLE_END_DATE` — test date range end (YYYY-MM-DD)

## License

MIT — See [LICENSE](./LICENSE) for details.
