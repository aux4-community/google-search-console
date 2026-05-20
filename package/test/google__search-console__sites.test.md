# google search-console sites

```timeout
15000
```

## list

### should return site entries

```execute
aux4 google search-console sites list
```

```expect:partial
"siteEntry"
```

## get

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
