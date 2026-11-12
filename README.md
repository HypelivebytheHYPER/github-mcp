# github-mcp

Kimi Code plugin wrapping the official [github-mcp-server](https://github.com/github/github-mcp-server) (GitHub's own MCP server) over stdio.

## Install

In the Kimi Code TUI:

```
/plugins install https://github.com/HypelivebytheHYPER/github-mcp
```

Then `/reload` or start a new session, and check `/mcp`.

The plugin is also installable from a local checkout: `/plugins install ~/kimi-plugins/github-mcp`.

## Auth (required for private repos, issues, PRs)

The server reads `GITHUB_PERSONAL_ACCESS_TOKEN`, which the launcher script takes from
`~/.kimi-code/credentials/github-mcp-token` (mode 600, single line).

1. Create a fine-grained personal access token: https://github.com/settings/personal-access-token/new
   - Start read-only (public repos read is enough for code search / browsing).
   - Add `Issues` / `Pull requests` read or write permission only when needed.
2. Store it:

   ```bash
   printf '%s' 'github_pat_...' > ~/.kimi-code/credentials/github-mcp-token
   chmod 600 ~/.kimi-code/credentials/github-mcp-token
   ```

3. Reconnect the server in `/mcp` (or `/reload`).

Without a token the server runs unauthenticated: public data only, heavily rate-limited.

## Layout

- `kimi.plugin.json` — plugin manifest; declares the `github` MCP server (`deferred: true`, tools load on demand)
- `start-github-mcp.sh` — launcher: exports the token, execs `~/bin/github-mcp-server stdio`

The machine-local binary at `~/bin/github-mcp-server` comes from the official release
assets (`github-mcp-server_Darwin_arm64.tar.gz`); upgrade by downloading a newer release.
