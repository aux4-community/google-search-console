#### Description

The `delete` command removes a site from your Search Console account. This does not affect the actual website — it only removes it from your Search Console property list. A confirmation prompt is shown before deletion; pass `--yes` to skip it.

Requires the write scope `https://www.googleapis.com/auth/webmasters`, which is what `aux4 google auth login` requests by default. After `aux4 google auth login --readonly true` only `webmasters.readonly` is granted and this command is rejected.

#### Usage

```bash
aux4 google search-console sites delete <siteUrl> [--tokenFile <path>] [--yes]
```

siteUrl      Site domain to remove (e.g. example.com) or URL-prefix property (e.g. https://example.com). Domain properties are auto-detected.
--tokenFile  Where the shared Google OAuth token is stored (default: `~/.aux4.config/.oauth/google.json`, env `AUX4_GOOGLE_TOKEN_FILE`)
--yes        Skip the confirmation prompt

#### Example

```bash
aux4 google search-console sites delete example.com
```
