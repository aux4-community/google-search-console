# google search-console sitemaps

Part of the `core` group in `test.suite.md`. The Search Console API is replaced by a
local echo server, which makes the double percent-encoding — the site property and
the sitemap feed path are both path segments — directly assertable.

## against a local mock API

```beforeAll
nohup python3 -c "
from http.server import HTTPServer, BaseHTTPRequestHandler
import json, threading, os
threading.Timer(90, lambda: os._exit(0)).start()

class Handler(BaseHTTPRequestHandler):
    def echo(self):
        length = int(self.headers.get('Content-Length') or 0)
        raw = self.rfile.read(length).decode() if length > 0 else ''
        payload = {
            'method': self.command,
            'path': self.path,
            'authorization': self.headers.get('Authorization'),
            'body': json.loads(raw) if raw else None
        }
        data = json.dumps(payload, indent=2, sort_keys=True).encode()
        self.send_response(200)
        self.send_header('Content-Type', 'application/json')
        self.send_header('Content-Length', str(len(data)))
        self.end_headers()
        self.wfile.write(data)
    do_GET = echo
    do_POST = echo
    do_PUT = echo
    do_DELETE = echo
    def log_message(self, fmt, *args):
        pass

HTTPServer(('127.0.0.1', 18954), Handler).serve_forever()
" >/dev/null 2>&1 &
sleep 3
```

```afterAll
pkill -f "18954" 2>/dev/null
```

```file:google-token.json
{
  "clientId": "test-client",
  "clientSecret": "test-secret",
  "authUrl": "https://accounts.google.com/o/oauth2/v2/auth",
  "tokenUrl": "https://oauth2.googleapis.com/token",
  "scopes": "https://www.googleapis.com/auth/webmasters",
  "accessToken": "test-access-token",
  "refreshToken": "test-refresh-token",
  "expiresAt": "2099-12-31T23:59:59Z"
}
```

### list should GET the sitemaps collection of the encoded site

```execute
aux4 google search-console sitemaps list example.com --tokenFile google-token.json --apiUrl http://127.0.0.1:18954
```

```expect:partial
"method": "GET"
```

```expect:partial
"path": "/webmasters/v3/sites/sc-domain%3Aexample.com/sitemaps"
```

### get should percent-encode both the site and the feed path

```execute
aux4 google search-console sitemaps get --siteUrl example.com --feedpath https://example.com/sitemap.xml --tokenFile google-token.json --apiUrl http://127.0.0.1:18954
```

```expect:partial
"path": "/webmasters/v3/sites/sc-domain%3Aexample.com/sitemaps/https%3A%2F%2Fexample.com%2Fsitemap.xml"
```

### submit should PUT the encoded sitemap resource

```execute
aux4 google search-console sitemaps submit --siteUrl example.com --feedpath https://example.com/sitemap.xml --tokenFile google-token.json --apiUrl http://127.0.0.1:18954
```

```expect:partial
"method": "PUT"
```

```expect:partial
"path": "/webmasters/v3/sites/sc-domain%3Aexample.com/sitemaps/https%3A%2F%2Fexample.com%2Fsitemap.xml"
```

### delete should DELETE the encoded sitemap resource

```execute
aux4 google search-console sitemaps delete --siteUrl example.com --feedpath https://example.com/sitemap.xml --yes --tokenFile google-token.json --apiUrl http://127.0.0.1:18954
```

```expect:partial
"method": "DELETE"
```

```expect:partial
"path": "/webmasters/v3/sites/sc-domain%3Aexample.com/sitemaps/https%3A%2F%2Fexample.com%2Fsitemap.xml"
```

### submit should accept a URL-prefix property

```execute
aux4 google search-console sitemaps submit --siteUrl https://example.com/ --feedpath https://example.com/sitemap.xml --tokenFile google-token.json --apiUrl http://127.0.0.1:18954
```

```expect:partial
"path": "/webmasters/v3/sites/https%3A%2F%2Fexample.com%2F/sitemaps/https%3A%2F%2Fexample.com%2Fsitemap.xml"
```
