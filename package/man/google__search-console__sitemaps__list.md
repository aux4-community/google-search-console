#### Description

The `list` command returns all sitemaps submitted for a site in Google Search Console. Each entry includes the sitemap URL, type, last submitted time, and status information.

#### Usage

```bash
aux4 google search-console sitemaps list <siteUrl> [--tokenFile <path>]
```

siteUrl      Site domain (e.g. example.com) or URL-prefix property (e.g. https://example.com). Domain properties are auto-detected.
--tokenFile  Where the shared Google OAuth token is stored (default: `~/.aux4.config/.oauth/google.json`, env `AUX4_GOOGLE_TOKEN_FILE`)

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
