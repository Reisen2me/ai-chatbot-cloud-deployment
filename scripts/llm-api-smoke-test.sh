#!/usr/bin/env bash
# Safe-ish local smoke test: does not persist keys or print response bodies.
# Requires curl and python3. TEST ONLY endpoints you trust.
set -euo pipefail
: "${LLM_BASE_URL:?Set LLM_BASE_URL, e.g. http://127.0.0.1:18900}"
: "${LLM_MODEL:?Set LLM_MODEL to your configured model ID}"
: "${LLM_API_KEY:?Set LLM_API_KEY in your current shell (do not commit it)}"
case "$LLM_BASE_URL" in
  http://127.0.0.1:*|http://localhost:*|https://*) ;;
  *) echo 'Use loopback HTTP or HTTPS for remote endpoints.' >&2; exit 2 ;;
esac
payload=$(python3 -c 'import json,os; print(json.dumps({"model":os.environ["LLM_MODEL"],"messages":[{"role":"user","content":"Reply with the word OK."}],"stream":False}))')
# Reply is discarded to avoid accidentally printing private provider output.
# curl returns non-zero on HTTP 4xx/5xx; timings are diagnostic, not benchmarks.
curl --fail --silent --show-error --max-time 60 --output /dev/null \
  --write-out 'HTTP %{http_code}; total %{time_total}s; connect %{time_connect}s\n' \
  -H "Authorization: Bearer ${LLM_API_KEY}" \
  -H 'Content-Type: application/json' \
  --data "$payload" "${LLM_BASE_URL%/}/v1/chat/completions"
