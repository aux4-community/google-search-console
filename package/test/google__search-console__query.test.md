# google search-console query

Part of the `core` group in `test.suite.md`. The Search Console API is replaced by a
local echo server, so the test asserts the request aux4 builds — method, path,
`Authorization` header and JSON body — without needing a real Google account.

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
            'contentType': self.headers.get('Content-Type'),
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

HTTPServer(('127.0.0.1', 18950), Handler).serve_forever()
" >/dev/null 2>&1 &
sleep 3
```

```afterAll
pkill -f "18950" 2>/dev/null
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

### should POST to the searchAnalytics endpoint with a bearer token

```execute
aux4 google search-console query example.com --startDate 2026-01-01 --endDate 2026-01-31 --tokenFile google-token.json --apiUrl http://127.0.0.1:18950
```

```expect:partial
"authorization": "Bearer test-access-token"
```

```expect:partial
"contentType": "application/json"
```

```expect:partial
"method": "POST"
```

### should percent-encode a plain domain as a sc-domain property in the path

```execute
aux4 google search-console query example.com --startDate 2026-01-01 --endDate 2026-01-31 --tokenFile google-token.json --apiUrl http://127.0.0.1:18950
```

```expect:partial
"path": "/webmasters/v3/sites/sc-domain%3Aexample.com/searchAnalytics/query"
```

### should percent-encode a URL-prefix property in the path

```execute
aux4 google search-console query https://example.com/ --startDate 2026-01-01 --endDate 2026-01-31 --tokenFile google-token.json --apiUrl http://127.0.0.1:18950
```

```expect:partial
"path": "/webmasters/v3/sites/https%3A%2F%2Fexample.com%2F/searchAnalytics/query"
```

### should keep an explicit sc-domain property unchanged

```execute
aux4 google search-console query sc-domain:example.com --startDate 2026-01-01 --endDate 2026-01-31 --tokenFile google-token.json --apiUrl http://127.0.0.1:18950
```

```expect:partial
"path": "/webmasters/v3/sites/sc-domain%3Aexample.com/searchAnalytics/query"
```

### should send numeric rowLimit and startRow and omit dimensions by default

```execute
aux4 google search-console query example.com --startDate 2026-01-01 --endDate 2026-01-31 --tokenFile google-token.json --apiUrl http://127.0.0.1:18950 | aux4 json get --path '$.body'
```

```expect:json
{
  "endDate": "2026-01-31",
  "rowLimit": 1000,
  "startDate": "2026-01-01",
  "startRow": 0,
  "type": "web"
}
```

### should turn comma-separated dimensions into a JSON array

```execute
aux4 google search-console query example.com --startDate 2026-01-01 --endDate 2026-01-31 --dimensions query,page --rowLimit 5 --startRow 10 --searchType image --tokenFile google-token.json --apiUrl http://127.0.0.1:18950 | aux4 json get --path '$.body'
```

```expect:json
{
  "dimensions": [
    "query",
    "page"
  ],
  "endDate": "2026-01-31",
  "rowLimit": 5,
  "startDate": "2026-01-01",
  "startRow": 10,
  "type": "image"
}
```

## without a stored token

### should report that the google provider has no token

```execute
aux4 google search-console query example.com --startDate 2026-01-01 --endDate 2026-01-31 --tokenFile ./no-such-directory/google.json --apiUrl http://127.0.0.1:18950
```

```error:partial
no token found for provider "google"
```
