<h1 align="center">MCP-Server for Obsidian on Unraid</h1>

<a href="https://github.com/MarkusPfundstein/mcp-obsidian">
  <img src="https://raw.githubusercontent.com/junkerderprovinz/mcp-obsidian/main/.github/assets/mcp-obsidian-banner.png" alt="MCP Obsidian" width="100%">
</a>

<p align="center">
  <a href="https://github.com/junkerderprovinz/mcp-obsidian/actions/workflows/build.yml"><img src="https://img.shields.io/github/actions/workflow/status/junkerderprovinz/mcp-obsidian/build.yml?branch=main&label=Build&style=for-the-badge&logo=githubactions&logoColor=white" alt="Build" height="36"></a>&nbsp;
  <a href="https://github.com/junkerderprovinz/mcp-obsidian/actions/workflows/lint.yml"><img src="https://img.shields.io/github/actions/workflow/status/junkerderprovinz/mcp-obsidian/lint.yml?branch=main&label=Lint&style=for-the-badge&logo=githubactions&logoColor=white" alt="Lint" height="36"></a>&nbsp;
  <a href="https://github.com/junkerderprovinz/mcp-obsidian/pkgs/container/mcp-obsidian"><img src="https://img.shields.io/badge/Image-ghcr.io-1d99f3?style=for-the-badge&logo=docker&logoColor=white" alt="Image" height="36"></a>&nbsp;
  <a href="https://github.com/junkerderprovinz/mcp-obsidian/pkgs/container/mcp-obsidian"><img src="https://img.shields.io/badge/Arch-amd64%20%7C%20arm64-success?style=for-the-badge&logo=linux&logoColor=white" alt="Arch" height="36"></a>&nbsp;
  <a href="https://modelcontextprotocol.io"><img src="https://img.shields.io/badge/Protocol-MCP-6c4ab6?style=for-the-badge&logo=anthropic&logoColor=white" alt="MCP" height="36"></a>&nbsp;
  <a href="https://obsidian.md"><img src="https://img.shields.io/badge/App-Obsidian-7c3aed?style=for-the-badge&logo=obsidian&logoColor=white" alt="Obsidian" height="36"></a>&nbsp;
  <a href="https://unraid.net"><img src="https://img.shields.io/badge/Unraid-Template-f15a2c?style=for-the-badge&logo=unraid&logoColor=white" alt="Unraid" height="36"></a>&nbsp;
  <a href="#"><img src="https://img.shields.io/badge/Status-Deprecated-b00020?style=for-the-badge&logo=github&logoColor=white" alt="Deprecated" height="36"></a>&nbsp;
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge&logo=opensourceinitiative&logoColor=white" alt="License" height="36"></a>
</p>

<p align="center">
Unraid Docker template for the MCP-server for Obsidian.<br>
Connects your local Obsidian Vault to AI agents like Open WebUI, Claude, or Gemini
via the <a href="https://modelcontextprotocol.io">Model Context Protocol (MCP)</a> —
no cloud sync, no third-party account, runs entirely on your own server.
</p>

<br>

<p align="center">
  <a href="https://buymeacoffee.com/junkerderprovinz">
    <img src=".github/assets/button-buy-me-a-coffee.svg" alt="Buy me a coffee" width="220">
  </a>
</p>

> [!WARNING]
> **Deprecated — this template has been withdrawn from Unraid Community Applications (2026-05-31).**
>
> The Obsidian [**Local REST API**](https://github.com/coddingtonbear/obsidian-local-rest-api)
> plugin now ships a **built-in MCP server** (`https://127.0.0.1:27124/mcp/`, or
> plain HTTP on `:27123/mcp/`, authenticated with the same bearer token). Point
> your MCP client straight at that endpoint — this wrapper container is no longer
> needed.
>
> The repository, the `ghcr.io/junkerderprovinz/mcp-obsidian` image and the
> support thread remain available for anyone still running the container, and the
> image is still rebuilt automatically (weekly) for base-image security patches.

<br>

## Table of Contents

1. [What is this?](#1-what-is-this)
2. [Quick Start on Unraid](#2-quick-start-on-unraid)
3. [Configuration](#3-configuration)
4. [Connecting to Open WebUI](#4-connecting-to-open-webui)
5. [Networking Notes](#5-networking-notes)
6. [Troubleshooting](#6-troubleshooting)
7. [Contributing / License](#7-contributing--license)
8. [Support this project](#8-support-this-project)

<br>

## 1. What is this?

This Unraid template wraps [mcp-obsidian](https://github.com/MarkusPfundstein/mcp-obsidian)
by Markus Pfundstein into a ready-to-use Docker container for Unraid.

**MCP (Model Context Protocol)** is an open standard introduced by Anthropic that lets
AI agents communicate with external tools and data sources through a common interface —
similar to how USB standardised device connections. Instead of every AI needing a custom
plugin for every tool, a single MCP server exposes capabilities that any compatible
client can use.

This container bridges your **Obsidian Vault** and any MCP-compatible AI client:

- AI agents can **search, read and write** notes directly in your Vault
- Works with **Open WebUI**, **Claude Desktop**, **Cursor**, **Zed** and any other MCP client
- Your notes stay **fully local** — no data leaves your server
- Compatible with **local LLMs** via Ollama as well as cloud models



### How it works

```
AI Client (Open WebUI / Claude / ...)
        |
        | MCP (port 9999)
        v
  mcp-obsidian container   <-- this template
        |
        | Local REST API (port 27124)
        v
  Obsidian App (running on your PC / server)
        |
        v
  Your Vault (Markdown files on disk)
```

<br>

## 2. Quick Start on Unraid


### Step 1 — Prepare Obsidian

Before installing the container, set up the Obsidian side:

1. Open Obsidian and go to **Settings → Community Plugins → Browse**.
2. Search for **Local REST API** and install it.
3. Enable the plugin and open its settings.
4. Under **Advanced Settings**, change the **Binding Host** from `127.0.0.1`
   to the actual IP address of the machine running Obsidian (e.g. `192.168.x.x`).
5. Note the **API Key** shown in the plugin settings — you will need it in Step 3.


### Step 2 — Run the container

> The Unraid Community Applications template has been **withdrawn** (see the
> deprecation notice above) and is no longer shipped in this repository. Run the
> image directly with the [Plain Docker](#plain-docker-no-unraid) command below.



### Step 3 — Set the two required values

The container needs exactly two values (set them as the `-e` environment variables
in the Plain Docker command below):

| Field | Env var | Value |
|---|---|---|
| **Obsidian API Key** | `OBSIDIAN_API_KEY` | The key from the Local REST API plugin |
| **Obsidian Host URL** | `OBSIDIAN_HOST` | `http://192.168.x.x:27124` |


### Plain Docker (no Unraid)

```bash
docker run -d \
  --name mcp-obsidian \
  --restart unless-stopped \
  -p 9999:9999 \
  -e OBSIDIAN_API_KEY=your_api_key_here \
  -e OBSIDIAN_HOST=http://192.168.1.50:27124 \
  ghcr.io/junkerderprovinz/mcp-obsidian:latest
```

<br>

## 3. Configuration

| Variable | Default | Required | Description |
|---|---|:---:|---|
| `OBSIDIAN_API_KEY` | *(empty)* | Yes | API key from the Local REST API plugin in Obsidian |
| `OBSIDIAN_HOST` | `http://192.168.x.x:27124` | Yes | URL of the machine running Obsidian with the plugin active |


### Ports

| Port | Purpose |
|---|---|
| `9999` | MCP server — AI clients connect here |

<br>

## 4. Connecting to Open WebUI

Once the container is running, register it as a tool server in Open WebUI:

1. Open your Open WebUI instance and log in as **Admin**.
2. Go to **Admin Settings → Tools → Manage Tool Servers**.
3. Click **Add Connection**.
4. Enter the container URL: `http://192.168.x.x:9999`
5. Leave the auth token field empty — security is handled by the API key
   between this container and Obsidian.
6. Click **Save**. The Obsidian tools now appear in your model's tool list.

From this point any model running through Open WebUI (local via Ollama or
cloud via API key) can search and edit your Vault mid-conversation.

<br>

## 5. Networking Notes


### Custom network (Unraid `br0`)

If your Unraid containers run on a custom network such as `br0` with individual
IPs, the containers cannot reach the **Unraid host IP** by default.

Make sure Obsidian is running on a **client machine** that is reachable from
the container's network (e.g. your desktop PC at `192.168.1.10`), or enable
**Host access to custom networks** in Unraid:

**Settings → Docker → Advanced View → Host access to custom networks: Enabled**


### Obsidian must be open

The Local REST API plugin only serves requests while **Obsidian is running**.
If Obsidian is closed, the MCP server will return connection errors to the AI client.

<br>

## 6. Troubleshooting

<details>
<summary><b>AI client cannot reach the MCP server</b></summary>

- Verify the container is running: `docker ps | grep mcp-obsidian`
- Check that port 9999 is reachable: `curl http://192.168.x.x:9999`
- If using a custom network, ensure Host access to custom networks is enabled
  (see [Networking Notes](#5-networking-notes))
</details>

<details>
<summary><b>MCP server cannot reach Obsidian (connection refused)</b></summary>

- Confirm Obsidian is open and the Local REST API plugin is enabled
- Verify the Binding Host in the plugin settings is set to the machine's
  actual IP — not `127.0.0.1`
- Test from the container: `docker exec mcp-obsidian curl http://192.168.x.x:27124`
</details>

<details>
<summary><b>401 Unauthorized from Obsidian</b></summary>

- The API key in the container does not match the one shown in the
  Local REST API plugin settings
- Re-copy the key from Obsidian → Settings → Local REST API and update the
  `OBSIDIAN_API_KEY` variable in the Unraid template
</details>

<details>
<summary><b>Tools do not appear in Open WebUI</b></summary>

- Make sure you added the connection in **Admin Settings**, not in personal user settings
- Restart Open WebUI after adding the tool server
- Verify the container IP and port are correct and reachable from the Open WebUI container
</details>

<br>

## 7. Contributing / License

Pull requests welcome. Issues: <https://github.com/junkerderprovinz/mcp-obsidian/issues>

This **wrapper repository** (Unraid template and README) is licensed under the
[MIT License](LICENSE).

**mcp-obsidian itself** is a separate project by Markus Pfundstein and retains
its own upstream license. See the [upstream repository](https://github.com/MarkusPfundstein/mcp-obsidian)
for details.



### Credits

- [**mcp-obsidian**](https://github.com/MarkusPfundstein/mcp-obsidian) — Markus Pfundstein, the actual MCP server
- [**Local REST API**](https://github.com/coddingtonbear/obsidian-local-rest-api) — coddingtonbear, the Obsidian plugin that makes this possible
- [**Anthropic**](https://anthropic.com) — for the open MCP standard

<br>

## 8. Support this project

If this template saved you a setup hassle or a debug night, consider buying me a coffee:

<p align="center">
  <a href="https://buymeacoffee.com/junkerderprovinz">
    <img src=".github/assets/button-buy-me-a-coffee.svg" alt="Buy me a coffee" width="220">
  </a>
</p>
