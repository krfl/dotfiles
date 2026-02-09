#!/usr/bin/env bash

# Claude Code Statusline Script
# Shows context usage and current working directory

input=$(cat)

# Extract a JSON value by key (handles strings and numbers)
jval() { echo "$input" | grep -o "\"$1\":[^,}]*" | sed "s/\"$1\"://;s/\"//g"; }

total_input=$(jval total_input_tokens)
total_output=$(jval total_output_tokens)
used_pct=$(jval used_percentage)
total_cost=$(jval total_cost_usd)
cwd=$(jval cwd)

# Default used_pct so all branches converge
used_pct=${used_pct:-0}
used_int=${used_pct%.*}

# Progress bar (width 10)
filled=$((used_int * 10 / 100))
empty=$((10 - filled))

if [ "$used_int" -gt 80 ]; then
    color="\033[31m"
elif [ "$used_int" -gt 60 ]; then
    color="\033[33m"
else
    color="\033[32m"
fi

bar="$(printf '%*s' "$filled" '' | tr ' ' '━')$(printf '%*s' "$empty" '' | tr ' ' '╺')"
context_bar=$(printf "${color}%s\033[0m" "$bar")

# Format tokens
total_tokens=$(( ${total_input:-0} + ${total_output:-0} ))
if [ "$total_tokens" -ge 1000 ]; then
    formatted_tokens="$((total_tokens / 1000))K"
else
    formatted_tokens="$total_tokens"
fi

# Format cost and cwd
formatted_cost=$(printf '$%.2f' "${total_cost:-0}")
formatted_cwd="${cwd:-~}"
formatted_cwd="${formatted_cwd/#$HOME/~}"

printf "CTX %s %s%% | Tokens: %s | Cost: %s | %s" \
    "${context_bar}" "${used_int}" "${formatted_tokens}" "${formatted_cost}" "${formatted_cwd}"
