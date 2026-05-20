#### Description

The `get` command retrieves detailed information about a specific sitemap, including its URL, type, submission time, and content breakdown (number of URLs, images, etc.).

#### Usage

```bash
aux4 google search-console sitemaps get <siteUrl> <feedpath>
```

siteUrl   Site URL (e.g. https://example.com)
feedpath  Sitemap URL (e.g. https://example.com/sitemap.xml)

#### Example

```bash
aux4 google search-console sitemaps get https://example.com https://example.com/sitemap.xml
```

```text
{
  "path": "https://example.com/sitemap.xml",
  "lastSubmitted": "2024-01-15T10:00:00.000Z",
  "isPending": false,
  "isSitemapsIndex": true,
  "type": "sitemap",
  "lastDownloaded": "2024-01-15T12:00:00.000Z",
  "contents": [
    {
      "type": "web",
      "submitted": "1250",
      "indexed": "1180"
    }
  ]
}
```
