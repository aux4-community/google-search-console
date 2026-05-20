#!/bin/bash
# Builds a URL inspection request and calls the Search Console API.
# Usage: inspect.sh <inspectionUrl> <siteUrl>

set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

INSPECTION_URL="$1"
SITE_URL="$2"

BODY=$(jq -n \
  --arg url "$INSPECTION_URL" \
  --arg site "$SITE_URL" \
  '{inspectionUrl: $url, siteUrl: $site}')

"$SCRIPT_DIR/gapi.sh" POST "https://searchconsole.googleapis.com/v1/urlInspection/index:inspect" "$BODY"
