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

SESSION_FILE="$HOME/.claude/til-session"

if [ -f "$SESSION_FILE" ]; then
    MSG="[TIL Config] Last used vault: ${VAULT_PATH}\n[TIL Incomplete Session] 이전 TIL 세션이 저장되지 않은 채로 끝났어요. /til을 실행하면 Claude에게 이어서 작성할지 물어봐요."
else
    MSG="[TIL Config] Last used vault: ${VAULT_PATH}"
fi

ESCAPED=$(escape_json "$MSG")
printf '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"%s"}}\n' "$ESCAPED"
exit 0
