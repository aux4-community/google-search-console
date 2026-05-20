#### Description

The `query` command retrieves search analytics data from Google Search Console. It returns clicks, impressions, CTR (click-through rate), and average position for your site's search results.

You can group results by dimensions such as query (search terms), page, country, device, date, or search appearance. Without dimensions, the response returns aggregate totals for the date range.

Data is typically available with a 2-3 day delay. Dates use PST timezone (UTC-8).

#### Usage

```bash
aux4 google search-console query <siteUrl> [--startDate <date>] [--endDate <date>] [--dimensions <dims>] [--searchType <type>] [--rowLimit <n>] [--startRow <n>]
```

siteUrl       Site domain (e.g. example.com) or URL-prefix property (e.g. https://example.com). Domain properties are auto-detected. Accepts example.com, sc-domain:example.com, or https://example.com.
--startDate   Start date in YYYY-MM-DD format (required)
--endDate     End date in YYYY-MM-DD format (required)
--dimensions  Comma-separated: query, page, country, device, searchAppearance, date
--searchType  Filter by search type: web (default), image, video, news, discover, googleNews
--rowLimit    Maximum rows to return, 1-25000 (default: 1000)
--startRow    Zero-based offset for pagination (default: 0)

#### Example

```bash
aux4 google search-console query example.com --startDate 2024-01-01 --endDate 2024-01-31 --dimensions query,page
```

```text
{
  "rows": [
    {
      "keys": ["example search term", "https://example.com/page"],
      "clicks": 150,
      "impressions": 3200,
      "ctr": 0.046875,
      "position": 4.2
    }
  ],
  "responseAggregationType": "byPage"
}
```

Get top search queries:

```bash
aux4 google search-console query example.com --startDate 2024-01-01 --endDate 2024-01-31 --dimensions query --rowLimit 50
```

Get performance by country:

```bash
aux4 google search-console query example.com --startDate 2024-01-01 --endDate 2024-01-31 --dimensions country
```

Get daily trend:

```bash
aux4 google search-console query example.com --startDate 2024-01-01 --endDate 2024-01-31 --dimensions date
```

Discover performance:

```bash
aux4 google search-console query example.com --startDate 2024-01-01 --endDate 2024-01-31 --searchType discover --dimensions page
```
