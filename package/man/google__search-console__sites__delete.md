#### Description

The `delete` command removes a site from your Search Console account. This does not affect the actual website — it only removes it from your Search Console property list. A confirmation prompt is shown before deletion.

Requires write scopes: `https://www.googleapis.com/auth/webmasters`

#### Usage

```bash
aux4 google search-console sites delete <siteUrl>
```

siteUrl  The site URL to remove

#### Example

```bash
aux4 google search-console sites delete https://example.com
```
