# env.nu
#
# Installed by:
# version = "0.101.1"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
# You can remove these comments if you want or leave
# them for future reference.

^ssh-agent -c 
    | lines
    | first 2
    | parse "setenv {name} {value};"
    | transpose -r 
    | into record
    | load-env

ssh-add -q ~/.ssh/thing-key

$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

zoxide init --cmd cd nushell | save -f ~/.zoxide.nu

mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu
