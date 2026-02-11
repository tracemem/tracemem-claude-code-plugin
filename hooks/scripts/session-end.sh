#!/bin/bash
# Log session end for diagnostics
# SessionEnd output is logged to debug only, not shown to user
echo '{"event": "session_end", "timestamp": "'$(date -u +%Y-%m-%dT%H:%M:%SZ)'"}'
