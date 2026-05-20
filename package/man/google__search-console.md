#### Description

The `google search-console` command group provides access to Google Search Console through the Search Console API. It uses the same authentication credentials managed by `gws` (Google Workspace CLI), with custom OAuth scopes for Search Console access.

Available subcommands:

- **query** — Query search analytics data (clicks, impressions, CTR, position)
- **inspect** — Inspect a URL's index status and crawl information
- **sites** — Manage verified sites (list, get, add, delete)
- **sitemaps** — Manage sitemaps (list, get, submit, delete)

#### Prerequisites

Authenticate with Search Console scopes before first use:

```bash
aux4 google auth login --scopes https://www.googleapis.com/auth/webmasters.readonly
```

For write access (add/delete sites, submit/delete sitemaps):

```bash
aux4 google auth login --scopes https://www.googleapis.com/auth/webmasters
```

#### Usage

```bash
aux4 google search-console <subcommand>
```

#### Example

```bash
aux4 google search-console sites list
aux4 google search-console query example.com --startDate 2024-01-01 --endDate 2024-01-31
```
