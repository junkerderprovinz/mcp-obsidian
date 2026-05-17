# syntax=docker/dockerfile:1.7
#
# mcp-obsidian for Unraid — runs the upstream MCP server
# (MarkusPfundstein/mcp-obsidian, stdio-only) behind mcp-proxy so it is
# reachable over the network on port 9999 by any MCP-over-SSE client
# (Open WebUI, Claude Desktop bridge, Cursor, Zed, ...).
#
ARG UPSTREAM_VERSION=0.2.2

FROM python:3.12-slim AS runtime

ARG UPSTREAM_VERSION

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    MCP_PROXY_HOST=0.0.0.0 \
    MCP_PROXY_PORT=9999

RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates curl tini \
 && rm -rf /var/lib/apt/lists/*

# Install upstream mcp-obsidian + mcp-proxy (stdio <-> SSE bridge)
RUN pip install --no-cache-dir \
        "mcp-obsidian==${UPSTREAM_VERSION}" \
        "mcp-proxy>=0.3.0"

# Non-root user for the runtime
RUN useradd --create-home --uid 1000 --shell /bin/bash mcp
USER mcp
WORKDIR /home/mcp

EXPOSE 9999

# OBSIDIAN_API_KEY and OBSIDIAN_HOST come from the Unraid template at runtime.
# We extract host:port from OBSIDIAN_HOST and pass them to the upstream tool
# as OBSIDIAN_HOST / OBSIDIAN_PORT (its expected vars).
COPY --chmod=0755 entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/bin/entrypoint.sh"]

LABEL org.opencontainers.image.title="mcp-obsidian" \
      org.opencontainers.image.description="MCP server for Obsidian (Unraid Docker template, upstream: MarkusPfundstein/mcp-obsidian)" \
      org.opencontainers.image.source="https://github.com/junkerderprovinz/mcp-obsidian" \
      org.opencontainers.image.url="https://github.com/junkerderprovinz/mcp-obsidian" \
      org.opencontainers.image.licenses="MIT"
