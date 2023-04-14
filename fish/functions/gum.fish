function gum_dirs
  zoxide query -ls | awk '{print $2}' | gum filter --reverse --placeholder="Filter directories..." --indicator="->" --match.foreground 1 --limit=1 | read foo
  if [ $foo ]
    cd $foo
    commandline -f repaint
  else
    commandline ''
  end
end

function gum_history
  history | gum filter --reverse --placeholder="Filter history..." --indicator="->" --match.foreground 1 --indicator.foreground 1 --limit=1 | read foo
  if [ $foo ]
    commandline $foo
  else
    commandline ''
  end
end

function omnigum
    echo ""
    
    set -l COMMANDS brew mas
    set -l COMMAND $(gum choose $COMMANDS)
    switch $COMMAND
    case brew
        set -l ACTIONS update uninstall remove_everything
        set -l ACTION $(gum choose $ACTIONS)
        echo $COMMAND $ACTION
        switch $ACTION
        case update
            brew update
            gum confirm && brew upgrade && brew cleanup && brew autoremove && brew doctor  || echo "Upgrade cancelled"
        case uninstall
            brew list | gum choose --no-limit | xargs brew uninstall
        case remove_everything
            brew remove --force $(brew list --formulae) --ignore-dependencies
            brew cleanup
            brew remove --cask --force $(brew list --cask)
        end
    case mas
        set -l ACTIONS update
        set -l ACTION $(gum choose $ACTIONS)
        echo $COMMAND $ACTION
        switch $ACTION
        case update
            mas outdated
            gum confirm && mas upgrade || echo "Upgrade cancelled"
        end
    end
    commandline -f kill-line
    commandline ''
end
