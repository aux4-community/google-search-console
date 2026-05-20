#### Description

The `submit` command submits a sitemap to Google Search Console for a site. This notifies Google that the sitemap is available for crawling. If the sitemap was previously submitted, this resubmits it.

Requires write scopes: `https://www.googleapis.com/auth/webmasters`

#### Usage

```bash
aux4 google search-console sitemaps submit <siteUrl> <feedpath>
```

siteUrl   Site domain (e.g. example.com) or URL-prefix property (e.g. https://example.com). Domain properties are auto-detected.
feedpath  Sitemap URL to submit (e.g. https://example.com/sitemap.xml)

#### Example

```bash
aux4 google search-console sitemaps submit example.com https://example.com/sitemap.xml
```
