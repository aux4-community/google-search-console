#### Description

The `add` command adds a new site to your Search Console account. After adding, you still need to verify ownership through one of the supported methods (DNS, HTML file, meta tag, etc.) using the Search Console web interface.

Requires write scopes: `https://www.googleapis.com/auth/webmasters`

#### Usage

```bash
aux4 google search-console sites add <siteUrl>
```

siteUrl  Site domain to add (e.g. example.com) or URL-prefix property (e.g. https://example.com). Domain properties are auto-detected.

#### Example

```bash
aux4 google search-console sites add example.com
```
