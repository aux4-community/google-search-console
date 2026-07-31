#### Description

The `delete` command removes a sitemap from the Search Console sitemaps report. This does not prevent Google from crawling the sitemap URL — it only removes it from the report. A confirmation prompt is shown before deletion; pass `--yes` to skip it.

This command takes two values, so pass them as the named flags `--siteUrl` and `--feedpath` rather than as bare positional arguments.

Requires the write scope `https://www.googleapis.com/auth/webmasters`, which is what `aux4 google auth login` requests by default. After `aux4 google auth login --readonly true` only `webmasters.readonly` is granted and this command is rejected.

#### Usage

```bash
aux4 google search-console sitemaps delete --siteUrl <url> --feedpath <url> [--tokenFile <path>] [--yes]
```

--siteUrl    Site domain (e.g. example.com) or URL-prefix property (e.g. https://example.com). Domain properties are auto-detected.
--feedpath   Sitemap URL to delete (e.g. https://example.com/sitemap.xml)
--tokenFile  Where the shared Google OAuth token is stored (default: `~/.aux4.config/.oauth/google.json`, env `AUX4_GOOGLE_TOKEN_FILE`)
--yes        Skip the confirmation prompt

#### Example

```bash
aux4 google search-console sitemaps delete --siteUrl example.com --feedpath https://example.com/sitemap.xml
```
