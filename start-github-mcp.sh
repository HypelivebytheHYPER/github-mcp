#!/bin/bash
# Launcher for the official github-mcp-server binary (installed at ~/bin).
# Token contract: GITHUB_PERSONAL_ACCESS_TOKEN is exported from
# ~/.kimi-code/credentials/github-mcp-token (mode 600, one line) when present.
set -euo pipefail

TOKEN_FILE="$HOME/.kimi-code/credentials/github-mcp-token"
if [ -f "$TOKEN_FILE" ]; then
  export GITHUB_PERSONAL_ACCESS_TOKEN="$(head -n1 "$TOKEN_FILE" | tr -d '[:space:]')"
else
  echo "github-mcp: no token file at $TOKEN_FILE — running unauthenticated (public data only, low rate limits)" >&2
fi

exec "$HOME/bin/github-mcp-server" stdio
