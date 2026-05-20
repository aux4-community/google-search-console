# google search-console sitemaps

```timeout
15000
```

## list

### should return sitemaps for the site

```execute
aux4 google search-console sitemaps list ${SEARCH_CONSOLE_SITE_URL}
```

```expect:partial
"sitemap"
```
