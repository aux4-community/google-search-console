#### Description

The `get` command retrieves information about a specific site in Search Console, including the site URL and the authenticated user's permission level.

#### Usage

```bash
aux4 google search-console sites get <siteUrl>
```

siteUrl  Site domain (e.g. example.com) or URL-prefix property (e.g. https://example.com). Domain properties are auto-detected. Accepts example.com, sc-domain:example.com, or https://example.com.

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
