#!/usr/bin/env bash

# Claude Code statusline
#
#   ~/github.com/dotfiles (master) │ Opus 5 xhigh · fast │ PR #1234 │ 5h 23% 1h42m │ 7d 84%
#   CTX ━╺╺╺╺╺╺╺╺╺ 51K (5% of 1M) │ $1.23 · 1h15m │ +156/-23
#
# Two lines: where you are and what is left on the first, what this session
# has cost on the second.
# Every segment carries a priority and each line is fitted to the terminal
# independently, dropping its least important segments until it fits. The
# directory and the context bar are priority 1 and never drop.
#
# Requires jq. Colors use the basic ANSI palette only, so they follow the
# terminal theme instead of fighting light/dark themes.

input=$(cat)

# Fields are joined with US (0x1f) rather than tab: tab counts as IFS
# whitespace, so bash would collapse runs of it and shift every empty field.
IFS=$'\x1f' read -r model effort fast cwd agent \
    pr_number pr_url pr_state \
    ctx_tokens ctx_pct ctx_size \
    rl5_pct rl5_reset rl7_pct \
    cost duration_ms lines_added lines_removed \
    <<<"$(jq -r '[
        .model.display_name // "?",
        .effort.level // "",
        (.fast_mode // false | tostring),
        (.workspace.current_dir // .cwd // ""),
        .agent.name // "",
        (.pr.number // "" | tostring),
        .pr.url // "",
        .pr.review_state // "",
        (.context_window.total_input_tokens // 0 | tostring),
        (.context_window.used_percentage // 0 | tostring),
        (.context_window.context_window_size // 200000 | tostring),
        (.rate_limits.five_hour.used_percentage // "" | tostring),
        (.rate_limits.five_hour.resets_at // "" | tostring),
        (.rate_limits.seven_day.used_percentage // "" | tostring),
        (.cost.total_cost_usd // 0 | tostring),
        (.cost.total_duration_ms // 0 | tostring),
        (.cost.total_lines_added // 0 | tostring),
        (.cost.total_lines_removed // 0 | tostring)
    ] | map(tostring | gsub("[\n\r]"; " ")) | join("\u001f")' <<<"$input" 2>/dev/null)"

cols=${COLUMNS:-120}
ctx_size=${ctx_size:-200000}
budget=$((cols - 4))
bar_width=10

# Keep only leading digits so arithmetic is safe on floats, empties and junk
int() { local v="${1%%.*}"; v="${v//[!0-9]/}"; echo "${v:-0}"; }

# Wrap text in an ANSI SGR code
c() { printf '\033[%sm%s\033[0m' "$1" "$2"; }

# Green under 60, yellow under 80, red above
level_color() {
    local p
    p=$(int "$1")
    if [ "$p" -ge 80 ]; then echo 31
    elif [ "$p" -ge 60 ]; then echo 33
    else echo 32
    fi
}

bar() {
    local pct filled empty
    pct=$(int "$1")
    [ "$pct" -gt 100 ] && pct=100
    filled=$((pct * bar_width / 100))
    [ "$pct" -gt 0 ] && [ "$filled" -eq 0 ] && filled=1
    empty=$((bar_width - filled))
    printf '%*s' "$filled" '' | tr ' ' '━'
    printf '%*s' "$empty" '' | tr ' ' '╺'
}

fmt_tokens() {
    local t
    t=$(int "$1")
    if [ "$t" -ge 1000000 ]; then
        printf '%d.%dM' $((t / 1000000)) $(((t % 1000000) / 100000))
    elif [ "$t" -ge 1000 ]; then
        printf '%dK' $((t / 1000))
    else
        printf '%d' "$t"
    fi
}

fmt_size() {
    local t
    t=$(int "$1")
    if [ "$t" -ge 1000000 ]; then printf '%dM' $((t / 1000000))
    else printf '%dK' $((t / 1000))
    fi
}

fmt_duration() {
    local s h m
    s=$(($(int "$1") / 1000))
    h=$((s / 3600))
    m=$((s % 3600 / 60))
    if [ "$h" -gt 0 ]; then printf '%dh%02dm' "$h" "$m"
    else printf '%dm%02ds' "$m" $((s % 60))
    fi
}

# Time remaining until an epoch-seconds deadline
fmt_until() {
    local rem h m
    rem=$(($(int "$1") - $(date +%s)))
    [ "$rem" -le 0 ] && return
    h=$((rem / 3600))
    m=$((rem % 3600 / 60))
    if [ "$h" -gt 0 ]; then printf '%dh%02dm' "$h" "$m"
    else printf '%dm' "$m"
    fi
}

# OSC 8 hyperlink; falls back to plain text when no URL is available
link() {
    if [ -n "$2" ]; then
        printf '\033]8;;%s\033\\%s\033]8;;\033\\' "$2" "$1"
    else
        printf '%s' "$1"
    fi
}

# ------------------------------------------------------------------ segments
#
# Each segment registers a line, a priority (lower survives longer), an ASCII
# plain form used only for width accounting, and the rendered form. The plain
# form must stay ASCII so ${#...} is a true column count regardless of locale:
# multi-byte glyphs are stood in for by single characters.

rows=() prios=() plains=() texts=()
add() {
    [ -z "$4" ] && return
    rows+=("$1")
    prios+=("$2")
    plains+=("$3")
    texts+=("$4")
}

# --- line 1: where you are

path="${cwd:-$PWD}"
path="${path/#$HOME/~}"
branch=$(git -C "${cwd:-.}" symbolic-ref --quiet --short HEAD 2>/dev/null \
    || git -C "${cwd:-.}" rev-parse --short HEAD 2>/dev/null)
add 1 1 "$path${branch:+ ($branch)}" \
    "$(c 36 "$path")${branch:+ $(c 2 "($branch)")}"
place_index=$((${#texts[@]} - 1))

mode_plain="" mode=""
[ -n "$effort" ] && { mode_plain="$effort"; mode=$(c 2 "$effort"); }
if [ "$fast" = "true" ]; then
    mode_plain+="${mode_plain:+ · }fast"
    mode+="${mode:+$(c 2 ' · ')}$(c 33 'fast')"
fi
add 1 2 "${model:-?}${mode_plain:+ $mode_plain}" \
    "$(c 1 "${model:-?}")${mode:+ $mode}"

# Open pull request, clickable, colored by review state
if [ -n "$pr_number" ]; then
    case "$pr_state" in
        approved) pr_color=32 ;;
        changes_requested) pr_color=31 ;;
        pending) pr_color=33 ;;
        *) pr_color=2 ;;
    esac
    add 1 4 "PR #$pr_number" "$(c "$pr_color" "$(link "PR #$pr_number" "$pr_url")")"
fi

[ -n "$agent" ] && add 1 5 "$agent" "$(c 35 "$agent")"

# Rate limits, registered separately so the 7-day window can be dropped alone
if [ -n "$rl5_pct" ]; then
    until5=$(fmt_until "$rl5_reset")
    add 1 3 "5h $(int "$rl5_pct")%${until5:+ $until5}" \
        "$(c 2 '5h') $(c "$(level_color "$rl5_pct")" "$(int "$rl5_pct")%")${until5:+ $(c 2 "$until5")}"
fi
[ -n "$rl7_pct" ] && add 1 6 "7d $(int "$rl7_pct")%" \
    "$(c 2 '7d') $(c "$(level_color "$rl7_pct")" "$(int "$rl7_pct")%")"

# --- line 2: what this session has cost

ctx_int=$(int "$ctx_pct")
ctx_color=$(level_color "$ctx_int")
ctx_tokens_fmt=$(fmt_tokens "$ctx_tokens")
ctx_suffix="(${ctx_int}% of $(fmt_size "$ctx_size"))"
ctx_bar_plain=$(printf '%*s' "$bar_width" '' | tr ' ' '-')
add 2 1 "CTX $ctx_bar_plain $ctx_tokens_fmt $ctx_suffix" \
    "$(c 2 'CTX') $(c "$ctx_color" "$(bar "$ctx_int")") $ctx_tokens_fmt $(c 2 "$ctx_suffix")"
ctx_index=$((${#texts[@]} - 1))

cost=${cost//[!0-9.]/}
spend_cost=$(printf '$%.2f' "${cost:-0}")
spend_time=$(fmt_duration "$duration_ms")
add 2 2 "$spend_cost · $spend_time" "$spend_cost$(c 2 ' · ')$spend_time"

added=$(int "$lines_added") removed=$(int "$lines_removed")
if [ "$added" -gt 0 ] || [ "$removed" -gt 0 ]; then
    add 2 3 "+$added/-$removed" \
        "$(c 32 "+$added")$(c 2 '/')$(c 31 "-$removed")"
fi

# ------------------------------------------------------------------ fitting

dropped=()

width() {
    local row=$1 total=0 n=0 i
    for i in "${!plains[@]}"; do
        [ "${rows[i]}" != "$row" ] && continue
        [ "${dropped[i]:-0}" = 1 ] && continue
        total=$((total + ${#plains[i]}))
        n=$((n + 1))
    done
    [ "$n" -gt 1 ] && total=$((total + 3 * (n - 1)))
    echo "$total"
}

# Drop a row's segments, least important first; priority 1 always survives
fit() {
    local row=$1 worst worst_prio i
    while [ "$(width "$row")" -gt "$budget" ]; do
        worst=-1 worst_prio=-1
        for i in "${!prios[@]}"; do
            [ "${rows[i]}" != "$row" ] && continue
            [ "${dropped[i]:-0}" = 1 ] && continue
            [ "${prios[i]}" -gt "$worst_prio" ] && { worst_prio=${prios[i]}; worst=$i; }
        done
        { [ "$worst" -lt 0 ] || [ "$worst_prio" -le 1 ]; } && break
        dropped[worst]=1
    done
}

# Shorten a long path before dropping segments: keeping the directory name and
# losing its parents costs less than losing the model or the PR outright
if [ "$(width 1)" -gt "$budget" ] && [ "${#path}" -gt 12 ]; then
    path="…/${path##*/}"
    # "." stands in for the one-column ellipsis; the plain form stays ASCII
    plains[place_index]=".${path#…}${branch:+ ($branch)}"
    texts[place_index]="$(c 36 "$path")${branch:+ $(c 2 "($branch)")}"
fi

fit 1
fit 2
# Last resort: drop the window size from the context segment
if [ "$(width 2)" -gt "$budget" ]; then
    ctx_suffix="(${ctx_int}%)"
    plains[ctx_index]="CTX $ctx_bar_plain $ctx_tokens_fmt $ctx_suffix"
    texts[ctx_index]="$(c 2 'CTX') $(c "$ctx_color" "$(bar "$ctx_int")") $ctx_tokens_fmt $(c 2 "$ctx_suffix")"
fi

render() {
    local row=$1 out="" i
    for i in "${!texts[@]}"; do
        [ "${rows[i]}" != "$row" ] && continue
        [ "${dropped[i]:-0}" = 1 ] && continue
        [ -n "$out" ] && out+=$(c 2 ' │ ')
        out+="${texts[i]}"
    done
    printf '%s' "$out"
}

printf '%s\n%s' "$(render 1)" "$(render 2)"
