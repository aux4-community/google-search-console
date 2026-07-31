#### Description

The `get` command retrieves detailed information about a specific sitemap, including its URL, type, submission time, and content breakdown (number of URLs, images, etc.).

Both the site property and the sitemap feed path are path segments of the request, and both are percent-encoded automatically.

This command takes two values, so pass them as the named flags `--siteUrl` and `--feedpath` rather than as bare positional arguments.

#### Usage

```bash
aux4 google search-console sitemaps get --siteUrl <url> --feedpath <url> [--tokenFile <path>]
```

--siteUrl    Site domain (e.g. example.com) or URL-prefix property (e.g. https://example.com). Domain properties are auto-detected.
--feedpath   Sitemap URL (e.g. https://example.com/sitemap.xml)
--tokenFile  Where the shared Google OAuth token is stored (default: `~/.aux4.config/.oauth/google.json`, env `AUX4_GOOGLE_TOKEN_FILE`)

#### Example

```bash
aux4 google search-console sitemaps get --siteUrl example.com --feedpath https://example.com/sitemap.xml
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
