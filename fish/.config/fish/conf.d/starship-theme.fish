# # Point starship at the day or night variant based on the CURRENT macOS appearance.
# # Loaded from conf.d so STARSHIP_CONFIG is set before `starship init` runs in config.fish.
# #
# # NOTE: we deliberately avoid `defaults read -g AppleInterfaceStyle`. With macOS
# # "Auto" appearance enabled it returns a STALE value (e.g. "Dark" long after the
# # system has switched to Light), which left the prompt stuck on the night theme.
# # AppleScript reports the true current state. It costs ~150ms, so the result is
# # cached and only re-detected every few seconds, or immediately when the terminal
# # regains focus (e.g. after toggling appearance in System Settings).

# set -g __starship_day   ~/.config/starship-day.toml
# set -g __starship_night ~/.config/starship-night.toml
# set -g __starship_ttl   3   # seconds between appearance re-checks

# function __starship_is_dark
#     test (uname) = Darwin; or return 1
#     osascript -e 'tell application "System Events" to tell appearance preferences to return dark mode' 2>/dev/null \
#         | string match -q true
# end

# function __set_starship_config --argument-names force
#     set -l now (date +%s)
#     set -l recheck 0
#     if test -n "$force"
#         set recheck 1
#     else if not set -q __starship_checked_at
#         set recheck 1
#     else if test (math "$now - $__starship_checked_at") -ge $__starship_ttl
#         set recheck 1
#     end

#     if test $recheck -eq 1
#         if __starship_is_dark
#             set -g __starship_mode dark
#         else
#             set -g __starship_mode light
#         end
#         set -g __starship_checked_at $now
#     end

#     if test "$__starship_mode" = dark
#         set -gx STARSHIP_CONFIG $__starship_night
#     else
#         set -gx STARSHIP_CONFIG $__starship_day
#     end
# end

# __set_starship_config

# # Re-evaluate before each prompt (throttled by __starship_ttl above)...
# function __starship_theme_on_prompt --on-event fish_prompt
#     __set_starship_config
# end

# # ...and immediately when the terminal regains focus, so a manual appearance
# # toggle is reflected without waiting for the throttle window.
# function __starship_theme_on_focus --on-event fish_focus_in
#     __set_starship_config force
# end
