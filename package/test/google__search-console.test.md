# google search-console

Part of the optional `integration` group in `test.suite.md`. These tests talk to the
real Search Console API, so they need a completed `aux4 google auth login` — a Google
Cloud OAuth Desktop client plus a human approving the consent screen in a browser.
They only run when asked for explicitly:

```bash
aux4 test run --group integration
```

Set these environment variables first:

- `SEARCH_CONSOLE_SITE_URL` — a verified property, for example `hub.aux4.io`
- `SEARCH_CONSOLE_START_DATE` — date range start (`YYYY-MM-DD`)
- `SEARCH_CONSOLE_END_DATE` — date range end (`YYYY-MM-DD`)

```timeout
15000
```

## sites

### should return site entries

```execute
aux4 google search-console sites list
```

```expect:partial
"siteEntry"
```

### should return site info

```execute
aux4 google search-console sites get ${SEARCH_CONSOLE_SITE_URL}
```

```expect:partial
"siteUrl"
```

```expect:partial
"permissionLevel"
```

## sitemaps

### should return sitemaps for the site

```execute
aux4 google search-console sitemaps list ${SEARCH_CONSOLE_SITE_URL}
```

```expect:partial
"sitemap"
```

## query

### should return search analytics data

```execute
aux4 google search-console query ${SEARCH_CONSOLE_SITE_URL} --startDate ${SEARCH_CONSOLE_START_DATE} --endDate ${SEARCH_CONSOLE_END_DATE}
```

```expect:partial
"rows"
```

### should return data grouped by query

```execute
aux4 google search-console query ${SEARCH_CONSOLE_SITE_URL} --startDate ${SEARCH_CONSOLE_START_DATE} --endDate ${SEARCH_CONSOLE_END_DATE} --dimensions query --rowLimit 5
```

```expect:partial
"keys"
```
