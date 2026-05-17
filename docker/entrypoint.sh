#!/usr/bin/env bash
# Entrypoint for the mcp-obsidian Unraid container.
# Bridges the stdio-only upstream MCP server to an SSE endpoint on
# ${MCP_PROXY_HOST}:${MCP_PROXY_PORT} (default 0.0.0.0:9999).
set -euo pipefail

: "${MCP_PROXY_HOST:=0.0.0.0}"
: "${MCP_PROXY_PORT:=9999}"

if [[ -z "${OBSIDIAN_API_KEY:-}" ]]; then
  echo "FATAL: OBSIDIAN_API_KEY is not set. Configure it in the Unraid template." >&2
  exit 1
fi

# Accept either a plain host or a full URL in OBSIDIAN_HOST.
# Upstream mcp-obsidian wants OBSIDIAN_HOST + OBSIDIAN_PORT separately.
raw="${OBSIDIAN_HOST:-http://127.0.0.1:27124}"
stripped="${raw#http://}"
stripped="${stripped#https://}"
stripped="${stripped%/}"

if [[ "$stripped" == *:* ]]; then
  host="${stripped%%:*}"
  port="${stripped##*:}"
else
  host="$stripped"
  port="${OBSIDIAN_PORT:-27124}"
fi

export OBSIDIAN_HOST="$host"
export OBSIDIAN_PORT="$port"

echo "Starting mcp-obsidian via mcp-proxy on ${MCP_PROXY_HOST}:${MCP_PROXY_PORT}"
echo "  Obsidian target: ${OBSIDIAN_HOST}:${OBSIDIAN_PORT}"

exec mcp-proxy \
  --host "${MCP_PROXY_HOST}" \
  --port "${MCP_PROXY_PORT}" \
  --pass-environment \
  -- mcp-obsidian
