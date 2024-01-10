# homebrew alias using gum
# updates then optionally  upgrades and cleans up
function brewup
    command brew update
    command echo ""
    # command gum confirm --affirmative="Upgrade" --negative="Cancel" --selected.background 6 --selected.foreground 0 && brew upgrade || echo "Upgrade cancelled"
    command brew upgrade
    command echo ""
    command brew cleanup
    command echo ""
    command brew autoremove
    command echo ""
    command brew doctor
end
