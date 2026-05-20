#### Description

The `google search-console sitemaps` command group manages sitemaps for your verified sites in Google Search Console. You can list submitted sitemaps, get details for a specific sitemap, submit new sitemaps, or delete existing ones.

Available subcommands:

- **list** — List sitemaps for a site
- **get** — Get information about a specific sitemap
- **submit** — Submit a sitemap
- **delete** — Delete a sitemap

#### Usage

```bash
aux4 google search-console sitemaps <subcommand>
```

#### Example

```bash
aux4 google search-console sitemaps list https://example.com
aux4 google search-console sitemaps submit https://example.com https://example.com/sitemap.xml
```
