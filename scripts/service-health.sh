#!/usr/bin/env bash
# A minimal original helper to inspect one or more systemd services.
set -euo pipefail
if [[ $# -eq 0 ]]; then
  set -- napcat
fi
for service in "$@"; do
  if [[ ! "$service" =~ ^[a-zA-Z0-9_.@-]+$ ]]; then
    printf 'Invalid service name: %s\n' "$service" >&2
    exit 2
  fi
  printf '\n=== %s ===\n' "$service"
  systemctl is-active "$service" || true
  systemctl status "$service" --no-pager --lines=5 || true
done
