#!/bin/bash
# Builds a Search Analytics query request and calls the Search Console API.
# Usage: query.sh <siteUrl> <startDate> <endDate> [dimensions] [searchType] [rowLimit] [startRow]

set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

SITE_URL="$1"
case "$SITE_URL" in
  https://*|http://*|sc-domain:*) ;;
  *) SITE_URL="sc-domain:$SITE_URL" ;;
esac
START_DATE="$2"
END_DATE="$3"
DIMENSIONS="${4:-}"
SEARCH_TYPE="${5:-web}"
ROW_LIMIT="${6:-1000}"
START_ROW="${7:-0}"

BODY=$(jq -n \
  --arg sd "$START_DATE" \
  --arg ed "$END_DATE" \
  --arg dims "$DIMENSIONS" \
  --arg st "$SEARCH_TYPE" \
  --argjson rl "$ROW_LIMIT" \
  --argjson sr "$START_ROW" \
  '{
    startDate: $sd,
    endDate: $ed,
    type: $st,
    rowLimit: $rl,
    startRow: $sr
  } + if $dims != "" then {dimensions: [$dims | split(",") | .[]]} else {} end')

ENCODED_URL=$(echo -n "$SITE_URL" | jq -Rr @uri)
"$SCRIPT_DIR/gapi.sh" POST "https://searchconsole.googleapis.com/webmasters/v3/sites/${ENCODED_URL}/searchAnalytics/query" "$BODY"
