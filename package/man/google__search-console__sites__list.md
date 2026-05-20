#### Description

The `list` command returns all sites that the authenticated user has access to in Google Search Console. Each entry includes the site URL and the user's permission level.

#### Usage

```bash
aux4 google search-console sites list
```

#### Example

```bash
aux4 google search-console sites list
```

```text
{
  "siteEntry": [
    {
      "siteUrl": "https://example.com/",
      "permissionLevel": "siteOwner"
    },
    {
      "siteUrl": "sc-domain:example.com",
      "permissionLevel": "siteOwner"
    }
  ]
}
```

Filter to just URLs:

```bash
aux4 google search-console sites list | jq '[.siteEntry[].siteUrl]'
```
