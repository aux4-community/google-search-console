#### Description

The `add` command adds a new site to your Search Console account. After adding, you still need to verify ownership through one of the supported methods (DNS, HTML file, meta tag, etc.) using the Search Console web interface.

Requires the write scope `https://www.googleapis.com/auth/webmasters`, which is what `aux4 google auth login` requests by default. After `aux4 google auth login --readonly true` only `webmasters.readonly` is granted and this command is rejected.

#### Usage

```bash
aux4 google search-console sites add <siteUrl> [--tokenFile <path>]
```

siteUrl      Site domain to add (e.g. example.com) or URL-prefix property (e.g. https://example.com). Domain properties are auto-detected.
--tokenFile  Where the shared Google OAuth token is stored (default: `~/.aux4.config/.oauth/google.json`, env `AUX4_GOOGLE_TOKEN_FILE`)

#### Example

```bash
aux4 google search-console sites add example.com
```
