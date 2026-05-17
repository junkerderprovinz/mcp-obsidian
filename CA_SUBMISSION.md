# Unraid Community Applications — Submission

This document describes how this repository is submitted to the
[Unraid Community Applications](https://forums.unraid.net/topic/38582-plug-in-community-applications/)
catalogue via [ca.unraid.net/submit](https://ca.unraid.net/submit/help).

## Repository details

| Field | Value |
|---|---|
| Repository | <https://github.com/junkerderprovinz/mcp-obsidian> |
| Template URL | <https://raw.githubusercontent.com/junkerderprovinz/mcp-obsidian/main/templates/mcp-obsidian.xml> |
| Icon | <https://raw.githubusercontent.com/junkerderprovinz/mcp-obsidian/main/.github/assets/mcp-obsidian-icon.png> |
| Docker image | `ghcr.io/junkerderprovinz/mcp-obsidian:latest` |
| Support thread | <https://forums.unraid.net/topic/198900-support-junkerderprovinz-mcp-obsidian/> |
| Maintainer | junkerderprovinz |
| License | MIT (wrapper) |

## Submission form

When submitting at <https://ca.unraid.net/submit>, use the following values:

- **GitHub URL**: `https://github.com/junkerderprovinz/mcp-obsidian`
- **Branch**: `main`
- **Templates path**: `templates`
- **Category**: `Tools:Utilities Productivity:`

## Pitch text (English, for the forum / submission notes)

> **mcp-obsidian** — Unraid Docker template for the MCP server for Obsidian.
>
> This template wraps Markus Pfundstein's `mcp-obsidian` into a ready-to-use
> Unraid container. It bridges a local Obsidian Vault (via the *Local REST API*
> community plugin) to any client speaking the Model Context Protocol — Open
> WebUI, Claude Desktop, Cursor, Zed, and others. AI agents can search, read
> and write notes directly in the Vault while everything stays on the user's
> own server.
>
> The Docker image is self-built (multi-arch amd64 + arm64) and published to
> `ghcr.io/junkerderprovinz/mcp-obsidian` via a daily GitHub Actions workflow
> that rebuilds from upstream `MarkusPfundstein/mcp-obsidian`.
>
> A dedicated support thread already exists on the Unraid forum.
>
> Many thanks to **@Squid** and the CA team for considering this for inclusion
> in Community Applications.

## Checklist before submission

- [x] `templates/mcp-obsidian.xml` is well-formed (`xmllint --noout`) and on `main`
- [x] `<Repository>` points to a published, publicly pullable image (`ghcr.io/junkerderprovinz/mcp-obsidian:latest`)
- [x] `<Icon>` URL is publicly reachable
- [x] `<Support>` URL points to the Unraid support thread
- [x] `<Project>` URL points to the GitHub repository
- [x] `<Network>` is `br0` (custom-IP friendly, falls back gracefully)
- [x] All defaults use generic placeholders (`192.168.1.50`, standard ports)
- [x] README and template contain no private data
- [x] A `v1.0.0` GitHub release exists
- [x] `Build` and `Lint` workflows are green on `main`
