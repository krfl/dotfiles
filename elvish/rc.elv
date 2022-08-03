# use github.com/zzamboni/elvish-completions/cd
# use github.com/zzamboni/elvish-completions/builtins
# use github.com/zzamboni/elvish-completions/git
# use github.com/zzamboni/elvish-modules/alias

# set paths = [
#   $@paths
# ]

fn ls {|@_args| clear ; exa --sort=type --icons $@_args }
fn ll {|@_args| clear ; exa -l --sort=type --icons --long $@_args }
fn tree {|@_args| exa --tree $@_args }
fn mon {|@_args| top -o cpu -O time $@_args }
fn brewup {|@_args| brew update ; brew upgrade ; brew cleanup ; brew doctor $@_args }
fn gotoicloud {|@_args| cd ~/Library/Mobile\ Documents/com\~apple\~CloudDocs/ $@_args }

eval (starship init elvish)

clear
date +"%d/%m/%Y"
date +"%H:%M:%S"
task next
