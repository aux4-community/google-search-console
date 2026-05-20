#### Description

The `delete` command removes a sitemap from the Search Console sitemaps report. This does not prevent Google from crawling the sitemap URL — it only removes it from the report. A confirmation prompt is shown before deletion.

Requires write scopes: `https://www.googleapis.com/auth/webmasters`

#### Usage

```bash
aux4 google search-console sitemaps delete <siteUrl> <feedpath>
```

siteUrl   Site domain (e.g. example.com) or URL-prefix property (e.g. https://example.com). Domain properties are auto-detected.
feedpath  Sitemap URL to delete (e.g. https://example.com/sitemap.xml)

#### Example

```bash
aux4 google search-console sitemaps delete example.com https://example.com/sitemap.xml
```
