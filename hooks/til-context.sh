#!/usr/bin/env bash
set -euo pipefail

# Exit if not in a TIL session
SESSION_FILE="$HOME/.claude/til-session"
[ -f "$SESSION_FILE" ] || exit 0

# Read vault path
VAULT_PATH=$(cat "$SESSION_FILE")
[ -d "$VAULT_PATH" ] || exit 0

# Parse user_prompt from stdin JSON
USER_PROMPT=$(python3 -c "
import json, sys
try:
    d = json.load(sys.stdin)
    print(d.get('user_prompt', ''))
except Exception:
    print('')
" 2>/dev/null || echo "")

[ -z "$USER_PROMPT" ] && exit 0

# Extract search terms: words longer than 3 chars, deduplicated, max 5
# Build alternation pattern for rg/grep
SEARCH_TERMS=$(echo "$USER_PROMPT" \
    | tr '[:space:][:punct:]' '\n' \
    | awk 'length > 3' \
    | sort -u \
    | head -5 \
    | paste -sd '|' -)

[ -z "$SEARCH_TERMS" ] && exit 0

# Search vault (ripgrep preferred, grep fallback)
if command -v rg >/dev/null 2>&1; then
    RESULTS=$(rg -l -e "$SEARCH_TERMS" \
        "$VAULT_PATH/til" \
        "$VAULT_PATH/study" \
        2>/dev/null | head -5 || true)
else
    RESULTS=$(grep -rl -E "$SEARCH_TERMS" \
        "$VAULT_PATH/til" \
        "$VAULT_PATH/study" \
        2>/dev/null | head -5 || true)
fi

[ -z "$RESULTS" ] && exit 0

# Build context lines
CONTEXT="[Related notes from vault]"
while IFS= read -r filepath; do
    [ -f "$filepath" ] || continue
    FILENAME=$(basename "$filepath")
    FIRST_HEADING=$(grep -m1 "^#" "$filepath" 2>/dev/null | sed 's/^#* //' || echo "")
    TAGS=$(grep -m1 "^tags:" "$filepath" 2>/dev/null | sed 's/^tags: *//' || echo "")
    CONTEXT="${CONTEXT}
- ${FILENAME}: ${FIRST_HEADING} (${TAGS})"
done <<< "$RESULTS"

# JSON-escape helper
escape_json() {
    local s="$1"
    s="${s//\\/\\\\}"
    s="${s//\"/\\\"}"
    s="${s//$'\n'/\\n}"
    s="${s//$'\r'/\\r}"
    s="${s//$'\t'/\\t}"
    printf '%s' "$s"
}

ESCAPED=$(escape_json "$CONTEXT")
printf '{"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":"%s"}}\n' "$ESCAPED"
exit 0
