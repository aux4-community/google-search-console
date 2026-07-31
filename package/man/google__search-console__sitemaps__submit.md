#### Description

The `submit` command submits a sitemap to Google Search Console for a site. This notifies Google that the sitemap is available for crawling. If the sitemap was previously submitted, this resubmits it and `lastSubmitted` advances.

Both the site property and the sitemap feed path are path segments of the request, and both are percent-encoded automatically.

This command takes two values, so pass them as the named flags `--siteUrl` and `--feedpath` rather than as bare positional arguments.

Requires the write scope `https://www.googleapis.com/auth/webmasters`, which is what `aux4 google auth login` requests by default. After `aux4 google auth login --readonly true` only `webmasters.readonly` is granted and this command is rejected.

#### Usage

```bash
aux4 google search-console sitemaps submit --siteUrl <url> --feedpath <url> [--tokenFile <path>]
```

--siteUrl    Site domain (e.g. example.com) or URL-prefix property (e.g. https://example.com). Domain properties are auto-detected.
--feedpath   Sitemap URL to submit (e.g. https://example.com/sitemap.xml)
--tokenFile  Where the shared Google OAuth token is stored (default: `~/.aux4.config/.oauth/google.json`, env `AUX4_GOOGLE_TOKEN_FILE`)

#### Example

```bash
aux4 google search-console sitemaps submit --siteUrl example.com --feedpath https://example.com/sitemap.xml
```

A successful submission returns an empty response. Confirm it with `sitemaps get`:

```bash
aux4 google search-console sitemaps get --siteUrl example.com --feedpath https://example.com/sitemap.xml
```
