# use github.com/zzamboni/elvish-completions/cd
# use github.com/zzamboni/elvish-completions/builtins
# use github.com/zzamboni/elvish-completions/git
# use github.com/zzamboni/elvish-modules/alias

set paths = [
  /opt/homebrew/bin
  /opt/homebrew/sbin
  $@paths
  /usr/local/bin
  /usr/sbin
  /sbin
  /Applications/Keybase.app/Contents/SharedSupport/bin
  /Library/Apple/usr/bin
  /Applications/kitty.app/Contents/MacOS
  ~/.cargo/bin
]

set E:EDITOR = hx

fn ls {|@_args| clear ; exa --sort=type --icons $@_args }
fn ll {|@_args| clear ; exa -l --sort=type --icons --long $@_args }
fn tree {|@_args| exa --tree $@_args }

fn mon {|@_args| top -o cpu -O time $@_args }
fn brewup {|@_args| brew update ; brew upgrade ; brew cleanup ; brew doctor $@_args }
fn gotoicloud {|@_args| cd '~/Library/Mobile Documents/com~apple~CloudDocs/' $@_args }
fn icat {|@_args| kitty +kitten icat $@_args }

eval (carapace _carapace|slurp)
eval (starship init elvish)

clear
date +"%d/%m/%Y"
date +"%H:%M:%S"
try { task next } catch e { put }
