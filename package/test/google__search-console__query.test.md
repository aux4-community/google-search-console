# google search-console query

```timeout
15000
```

## with default options

### should return search analytics data

```execute
aux4 google search-console query ${SEARCH_CONSOLE_SITE_URL} --startDate ${SEARCH_CONSOLE_START_DATE} --endDate ${SEARCH_CONSOLE_END_DATE}
```

```expect:partial
"rows"
```

## with dimensions

### should return data grouped by query

```execute
aux4 google search-console query ${SEARCH_CONSOLE_SITE_URL} --startDate ${SEARCH_CONSOLE_START_DATE} --endDate ${SEARCH_CONSOLE_END_DATE} --dimensions query --rowLimit 5
```

```expect:partial
"keys"
```
