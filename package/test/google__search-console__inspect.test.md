# google search-console inspect

Part of the `core` group in `test.suite.md`. The URL Inspection API is replaced by a
local echo server so the request body can be asserted without a real Google account.

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
    def log_message(self, fmt, *args):
        pass

HTTPServer(('127.0.0.1', 18951), Handler).serve_forever()
" >/dev/null 2>&1 &
sleep 3
```

```afterAll
pkill -f "18951" 2>/dev/null
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

### should POST to the urlInspection endpoint

```execute
aux4 google search-console inspect https://example.com/page --siteUrl example.com --tokenFile google-token.json --apiUrl http://127.0.0.1:18951
```

```expect:partial
"method": "POST"
```

```expect:partial
"path": "/v1/urlInspection/index:inspect"
```

### should send the resolved sc-domain property in the body, not in the path

```execute
aux4 google search-console inspect https://example.com/page --siteUrl example.com --tokenFile google-token.json --apiUrl http://127.0.0.1:18951 | aux4 json get --path '$.body'
```

```expect:json
{
  "inspectionUrl": "https://example.com/page",
  "siteUrl": "sc-domain:example.com"
}
```

### should keep a URL-prefix property unchanged in the body

```execute
aux4 google search-console inspect https://example.com/page --siteUrl https://example.com/ --tokenFile google-token.json --apiUrl http://127.0.0.1:18951 | aux4 json get --path '$.body'
```

```expect:json
{
  "inspectionUrl": "https://example.com/page",
  "siteUrl": "https://example.com/"
}
```
