#!/usr/bin/env bash
# Simple local service status check; no privileged changes or automatic restart.
set -u
for service in "$@"; do
  if [[ ! "$service" =~ ^[a-zA-Z0-9_.@-]+$ ]]; then
    printf 'Invalid service name: %s\n' "$service" >&2
    continue
  fi
  status=$(systemctl is-active "$service" 2>/dev/null || true)
  printf '%s: %s\n' "$service" "${status:-unknown}"
done
