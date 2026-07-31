#### Description

The `google search-console` command group provides access to Google Search Console through the Search Console API and the Indexing API. Every request is signed with the shared Google OAuth2 token that `community/google-auth` maintains, so there is nothing to configure beyond a single login.

Available subcommands:

- **query** — Query search analytics data (clicks, impressions, CTR, position)
- **inspect** — Inspect a URL's index status and crawl information
- **index** — Ask Google to crawl a new, updated or removed URL
- **sites** — Manage verified sites (list, get, add, delete)
- **sitemaps** — Manage sitemaps (list, get, submit, delete)

#### Prerequisites

Authenticate once before first use. Scopes are resolved from the installed Google service packages, so no `--scopes` flag is required:

```bash
aux4 google auth login
```

This package requests read-write Search Console access (`https://www.googleapis.com/auth/webmasters`) plus the Indexing API scope (`https://www.googleapis.com/auth/indexing`). Log in with `--readonly true` to request `https://www.googleapis.com/auth/webmasters.readonly` instead; `sites add`, `sites delete`, `sitemaps submit`, `sitemaps delete` and `index` then stop working.

The token is read from `~/.aux4.config/.oauth/google.json`. Override it per command with `--tokenFile`, or for the whole shell with the `AUX4_GOOGLE_TOKEN_FILE` environment variable.

#### Usage

```bash
aux4 google search-console <subcommand>
```

#### Example

```bash
aux4 google search-console sites list
aux4 google search-console query example.com --startDate 2024-01-01 --endDate 2024-01-31
```
