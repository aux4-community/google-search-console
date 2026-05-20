#### Description

The `get` command retrieves information about a specific site in Search Console, including the site URL and the authenticated user's permission level.

#### Usage

```bash
aux4 google search-console sites get <siteUrl>
```

siteUrl  The site URL including protocol (e.g. https://example.com or sc-domain:example.com)

#### Example

```bash
aux4 google search-console sites get https://example.com
```

```text
{
  "siteUrl": "https://example.com/",
  "permissionLevel": "siteOwner"
}
```
