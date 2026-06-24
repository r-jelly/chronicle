#!/usr/bin/env bash
set -euo pipefail

CONFIG_FILE="$HOME/.claude/til-config.json"
[ -f "$CONFIG_FILE" ] || exit 0

VAULT_PATH=$(python3 -c "
import json, os
try:
    d = json.load(open(os.path.expanduser('~/.claude/til-config.json')))
    print(d.get('vault_path', ''))
except Exception:
    print('')
" 2>/dev/null || echo "")

[ -z "$VAULT_PATH" ] && exit 0
[ -d "$VAULT_PATH" ] || exit 0

escape_json() {
    local s="$1"
    s="${s//\\/\\\\}"
    s="${s//\"/\\\"}"
    s="${s//$'\n'/\\n}"
    s="${s//$'\r'/\\r}"
    s="${s//$'\t'/\\t}"
    printf '%s' "$s"
}

MSG="[TIL Config] Last used vault: ${VAULT_PATH}"
ESCAPED=$(escape_json "$MSG")
printf '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"%s"}}\n' "$ESCAPED"
exit 0
