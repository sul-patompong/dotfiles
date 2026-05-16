#!/usr/bin/env bash
# Claude Code status line: model · dir · branch · context%
# Receives session JSON on stdin; prints a single line to stdout.

set -u

input=$(cat)

model=$(printf '%s' "$input" | jq -r '.model.display_name // .model.id // "Claude"')
model_id=$(printf '%s' "$input" | jq -r '.model.id // ""')
transcript=$(printf '%s' "$input" | jq -r '.transcript_path // ""')
cwd=$(printf '%s' "$input" | jq -r '.workspace.current_dir // .cwd // ""')

# Context window — 1M for [1m] models, else 200k.
if [[ "$model_id" == *"[1m]"* ]]; then
    limit=1000000
else
    limit=200000
fi

# Most recent assistant usage record in the transcript.
tokens=0
if [[ -f "$transcript" ]]; then
    tokens=$(tail -r "$transcript" 2>/dev/null \
        | jq -r 'select(.message.usage) | .message.usage
                 | (.input_tokens // 0)
                 + (.cache_read_input_tokens // 0)
                 + (.cache_creation_input_tokens // 0)' 2>/dev/null \
        | head -n1)
    tokens=${tokens:-0}
fi

fmt_num() {
    awk -v n="$1" 'BEGIN{
        if (n >= 1000000) printf "%.1fM", n/1000000;
        else if (n >= 1000) printf "%.1fk", n/1000;
        else printf "%d", n;
    }'
}

pct=$(awk -v t="$tokens" -v l="$limit" 'BEGIN{printf "%.0f", (t/l)*100}')

branch=""
if [[ -n "$cwd" ]] && command -v git >/dev/null 2>&1; then
    branch=$(git -C "$cwd" branch --show-current 2>/dev/null)
fi

dirname=$(basename "$cwd")

# Colors (muted gray, yellow >50%, red >80%).
DIM=$'\033[2;37m'
RESET=$'\033[0m'
if   (( pct >= 80 )); then PCT_COLOR=$'\033[31m'
elif (( pct >= 50 )); then PCT_COLOR=$'\033[33m'
else                       PCT_COLOR=$'\033[2;37m'
fi

line="${model}${DIM}  ${RESET}${dirname}"
[[ -n "$branch" ]] && line="${line}${DIM}  ${RESET}${branch}"
line="${line}${DIM}  ${RESET}${PCT_COLOR}${pct}% ($(fmt_num "$tokens")/$(fmt_num "$limit"))${RESET}"

printf '%s' "$line"
