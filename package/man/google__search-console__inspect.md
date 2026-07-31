#### Description

The `inspect` command performs a URL inspection using the Search Console API. It returns the index status, crawl information, and any issues found for a specific URL on your verified site.

The inspection URL must belong to the site specified by `--siteUrl`. This is equivalent to the URL Inspection tool in the Search Console web interface.

#### Usage

```bash
aux4 google search-console inspect <inspectionUrl> [--siteUrl <url>] [--tokenFile <path>]
```

inspectionUrl  The URL to inspect (must be under the specified site)
--siteUrl      Site domain (e.g. example.com) or URL-prefix property (e.g. https://example.com). Domain properties are auto-detected.
--tokenFile    Where the shared Google OAuth token is stored (default: `~/.aux4.config/.oauth/google.json`, env `AUX4_GOOGLE_TOKEN_FILE`)

#### Example

```bash
aux4 google search-console inspect https://example.com/page --siteUrl example.com
```

```text
{
  "inspectionResult": {
    "inspectionResultLink": "https://search.google.com/search-console/inspect?...",
    "indexStatusResult": {
      "verdict": "PASS",
      "coverageState": "Submitted and indexed",
      "lastCrawlTime": "2024-01-15T10:30:00Z",
      "pageFetchState": "SUCCESSFUL",
      "crawledAs": "DESKTOP",
      "robotsTxtState": "ALLOWED",
      "indexingState": "INDEXING_ALLOWED"
    }
  }
}
```
