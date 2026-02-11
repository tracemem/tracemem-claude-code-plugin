---
description: "Verify TraceMem plugin setup and connectivity"
allowed-tools:
  - Bash
  - mcp__tracemem__capabilities_get
---

# TraceMem Doctor

Verify that the TraceMem plugin is correctly configured and connected.

## Instructions

1. Check that `TRACEMEM_API_KEY` is set in the environment (do NOT display the key value — just confirm present/absent).

2. Call `mcp__tracemem__capabilities_get` to test connectivity to the TraceMem MCP server.

3. Report:
   - API key status: ✅ set / ❌ missing
   - MCP server URL: the configured URL (default: https://mcp.tracemem.com)
   - Connectivity: ✅ connected / ❌ unreachable
   - Server capabilities: list available tools
   - Plugin version: from plugin.json

4. If anything fails, provide actionable troubleshooting steps:
   - Missing API key → "Set TRACEMEM_API_KEY in your environment or .env file"
   - Connection failure → "Check your network and TRACEMEM_MCP_URL setting"
