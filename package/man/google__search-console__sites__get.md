#### Description

The `get` command retrieves information about a specific site in Search Console, including the site URL and the authenticated user's permission level.

#### Usage

```bash
aux4 google search-console sites get <siteUrl> [--tokenFile <path>]
```

siteUrl      Site domain (e.g. example.com) or URL-prefix property (e.g. https://example.com). Domain properties are auto-detected. Accepts example.com, sc-domain:example.com, or https://example.com.
--tokenFile  Where the shared Google OAuth token is stored (default: `~/.aux4.config/.oauth/google.json`, env `AUX4_GOOGLE_TOKEN_FILE`)

#### Example

```bash
aux4 google search-console sites get example.com
```

```text
{
  "siteUrl": "https://example.com/",
  "permissionLevel": "siteOwner"
}
```
