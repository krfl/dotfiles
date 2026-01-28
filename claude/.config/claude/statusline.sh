#!/usr/bin/env bash

# Claude Code Statusline Script
# Shows context usage and current working directory

# Read JSON input from Claude Code
input=$(cat)

# Parse JSON values using grep/sed (avoiding jq dependency)
total_input=$(echo "$input" | grep -o '"total_input_tokens":[0-9]*' | grep -o '[0-9]*')
total_output=$(echo "$input" | grep -o '"total_output_tokens":[0-9]*' | grep -o '[0-9]*')
context_size=$(echo "$input" | grep -o '"context_window_size":[0-9]*' | grep -o '[0-9]*')
used_pct=$(echo "$input" | grep -o '"used_percentage":[0-9.]*' | grep -o '[0-9.]*')
remaining_pct=$(echo "$input" | grep -o '"remaining_percentage":[0-9.]*' | grep -o '[0-9.]*')
total_cost=$(echo "$input" | grep -o '"total_cost_usd":[0-9.]*' | grep -o '[0-9.]*')
cwd=$(echo "$input" | grep -o '"cwd":"[^"]*"' | sed 's/"cwd":"//;s/"//')

# Function to create a progress bar from percentage
create_bar_from_pct() {
    local pct=$1
    local width=10

    if [ -z "$pct" ]; then
        echo "━━━━━━━━━━"
        return
    fi

    # Convert to integer percentage
    local percentage=${pct%.*}
    local filled=$((percentage * width / 100))
    local empty=$((width - filled))

    # Color based on usage (inverted since this is "used" percentage)
    local color=""
    if [ "$percentage" -gt 80 ]; then
        color="\033[31m"  # Red
    elif [ "$percentage" -gt 60 ]; then
        color="\033[33m"  # Yellow
    else
        color="\033[32m"  # Green
    fi

    local bar=""
    for ((i=0; i<filled; i++)); do bar+="━"; done
    for ((i=0; i<empty; i++)); do bar+="╺"; done

    printf "${color}${bar}\033[0m"
}

# Format working directory
format_cwd() {
    if [ -z "$cwd" ]; then
        echo "~"
        return
    fi

    # Replace home directory with ~
    local formatted="${cwd/#$HOME/~}"
    echo "$formatted"
}

# Format token count
format_tokens() {
    local input=$1
    local output=$2

    if [ -z "$input" ] || [ -z "$output" ]; then
        echo "0"
        return
    fi

    local total=$((input + output))

    # Format as K (thousands)
    if [ "$total" -ge 1000 ]; then
        local k=$((total / 1000))
        echo "${k}K"
    else
        echo "$total"
    fi
}

# Format cost
format_cost() {
    local cost=$1

    if [ -z "$cost" ]; then
        echo "\$0.00"
        return
    fi

    printf "\$%.2f" "$cost"
}

# Build statusline
context_bar=$(create_bar_from_pct "$used_pct")
used_int=${used_pct%.*}
formatted_cwd=$(format_cwd)
formatted_tokens=$(format_tokens "$total_input" "$total_output")
formatted_cost=$(format_cost "$total_cost")

# Output statusline with context usage, tokens, cost, and current directory
if [ -n "$used_pct" ]; then
    printf "CTX ${context_bar} ${used_int}%% | Tokens: ${formatted_tokens} | Cost: ${formatted_cost} | ${formatted_cwd}"
else
    # No context data yet
    printf "CTX ━━━━━━━━━━ 0%% | Tokens: ${formatted_tokens} | Cost: ${formatted_cost} | ${formatted_cwd}"
fi
