#### Description

The `list` command returns all sitemaps submitted for a site in Google Search Console. Each entry includes the sitemap URL, type, last submitted time, and status information.

#### Usage

```bash
aux4 google search-console sitemaps list <siteUrl>
```

siteUrl  Site domain (e.g. example.com) or URL-prefix property (e.g. https://example.com). Domain properties are auto-detected.

#### Example

```bash
aux4 google search-console sitemaps list example.com
```

```text
{
  "sitemap": [
    {
      "path": "https://example.com/sitemap.xml",
      "lastSubmitted": "2024-01-15T10:00:00.000Z",
      "isPending": false,
      "isSitemapsIndex": true,
      "type": "sitemap",
      "lastDownloaded": "2024-01-15T12:00:00.000Z"
    }
  ]
}
```
