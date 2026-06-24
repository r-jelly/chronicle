#!/usr/bin/env bash
set -euo pipefail

# Only act if a TIL session is open
SESSION_FILE="$HOME/.claude/til-session"
[ -f "$SESSION_FILE" ] || exit 0

escape_json() {
    local s="$1"
    s="${s//\\/\\\\}"
    s="${s//\"/\\\"}"
    s="${s//$'\n'/\\n}"
    s="${s//$'\r'/\\r}"
    s="${s//$'\t'/\\t}"
    printf '%s' "$s"
}

MSG="TIL_INCOMPLETE: TIL 세션이 저장되지 않은 채로 끝났어요. 이어서 마크다운 초안을 만들고 저장할까요? 취소하려면 '취소'라고 알려줘요."
ESCAPED=$(escape_json "$MSG")
printf '{"hookSpecificOutput":{"hookEventName":"Stop","additionalContext":"%s"}}\n' "$ESCAPED"
exit 0
