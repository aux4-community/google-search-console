#### Description

The `index` command publishes a URL notification to the Google Indexing API, asking Google to crawl a URL sooner than it otherwise would. Use `URL_UPDATED` for a new or changed page and `URL_DELETED` to report that a page has been removed.

The notification is a request, not a guarantee — Google decides whether and when to crawl. The API is rate limited per project (200 notifications per day by default), and the URL must belong to a property you own in Search Console.

This command needs the write-only scope `https://www.googleapis.com/auth/indexing`, which has no read-only counterpart. After `aux4 google auth login --readonly true` the scope is not requested and the call is rejected.

#### Usage

```bash
aux4 google search-console index <url> [--type <URL_UPDATED|URL_DELETED>] [--tokenFile <path>]
```

url          Full URL to notify Google about
--type       Notification type: `URL_UPDATED` (default) or `URL_DELETED`
--tokenFile  Where the shared Google OAuth token is stored (default: `~/.aux4.config/.oauth/google.json`, env `AUX4_GOOGLE_TOKEN_FILE`)

#### Example

```bash
aux4 google search-console index https://example.com/blog/new-post
```

```text
{
  "urlNotificationMetadata": {
    "url": "https://example.com/blog/new-post",
    "latestUpdate": {
      "url": "https://example.com/blog/new-post",
      "type": "URL_UPDATED",
      "notifyTime": "2024-01-15T10:30:00.123456Z"
    }
  }
}
```

Report a removed page:

```bash
aux4 google search-console index https://example.com/blog/old-post --type URL_DELETED
```
