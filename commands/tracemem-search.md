---
description: "Search past TraceMem decisions for precedent"
argument-hint: "[query] [--category=<cat>] [--tag=<tag>] [--status=<status>]"
allowed-tools:
  - mcp__tracemem__decision_search
---

# Search TraceMem Decisions

Search past decisions recorded in TraceMem. Use this to find precedent, check for existing decisions before recording new ones, or review your project's decision history.

## Instructions

1. Parse the user's input for search parameters:
   - **query**: Free-text search string (the main argument)
   - **category**: Filter by category — one of `architecture`, `dependency`, `schema`, `api_design`, `infra`, `tradeoff`, `convention`, `other`
   - **tag**: Filter by tag
   - **status**: Filter by status — `committed`, `aborted`, etc.

2. Call `mcp__tracemem__decision_search` with the parsed parameters:
   - `query`: the search text (if provided)
   - `category`: category filter (if provided)
   - `tags`: array of tags (if provided)
   - `status`: status filter (if provided)
   - `limit`: default to 10 results

3. Display results in a readable format:
   - Decision ID
   - Title
   - Category
   - Tags
   - Status
   - Created date
   - Whether it supersedes or is superseded by another decision

4. If no results found, suggest broadening the search or trying different terms.

5. If results are found and the user seems to be looking for precedent before making a new decision, suggest using `/tracemem-record` to record the new decision (optionally superseding an existing one).
