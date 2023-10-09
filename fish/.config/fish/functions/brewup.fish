# homebrew alias using gum
# updates then optionally  upgrades and cleans up
function brewup
    command brew update
    command gum confirm --affirmative="Upgrade" --negative="Cancel" --selected.background 6 --selected.foreground 0 && brew upgrade && brew cleanup && brew autoremove && brew doctor  || echo "Upgrade cancelled"
end
