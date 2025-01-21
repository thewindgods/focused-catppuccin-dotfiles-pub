# config.nu
#
# Installed by:
# version = "0.101.1"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

$env.PROMPT_INDICATOR_VI_NORMAL = { '' }
$env.PROMPT_INDICATOR_VI_INSERT = { '' } 
$env.config.buffer_editor = "nvim"

source ~/.config/nushell/catppuccin_mocha.nu
source ~/.zoxide.nu
source ~/.cache/carapace/init.nu

let external_completer = {|spans|
    fish --command $'complete "--do-complete=($spans | str join " ")"'
    | from tsv --flexible --noheaders --no-infer
    | rename value description
}

$env.config = {
  show_banner: false
  edit_mode: 'vi'
  completions: {
    external: {
      enable: true
      completer: $external_completer
    }
  }
  filesize: {
      metric: true # true => KB, MB, GB (ISO standard), false => KiB, MiB, GiB (Windows standard)
      format: "auto" # b, kb, kib, mb, mib, gb, gib, tb, tib, pb, pib, eb, eib, auto
  }
  cursor_shape: {
      emacs: block # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (line is the default)
      vi_insert: line # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (block is the default)
      vi_normal: block # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (underscore is the default)
  }
  keybindings: [    
        {
            name: copy_selection
            modifier: none
            keycode: char_y
            mode: vi_normal
            #event: { edit: copyselection }
            event: { edit: copyselectionsystem }
        }
       # {
       #     name: cut_selection
       #     modifier: none
       #     keycode: char_x
       #     mode: vi_normal
       #     #event: { edit: cutselection }
       #     event: { edit: cutselectionsystem }
       # }
       # {
       #     name: cut_selection
       #     modifier: none
       #     keycode: char_d
       #     mode: vi_normal
       #     event: [
       #         { edit: cutselectionsystem }
       #         { send: esc }
       #     ]
       # }
        {
            name: paste_system
            modifier: none
            keycode: char_p
            mode: vi_normal
            event: { edit: pastesystem }
        }
        {
            name: select_all
            modifier: shift
            keycode: char_v
            mode: vi_normal
            event: { edit: selectall }
        }
        {
            name: cut_buffer_before
            modifier: control
            keycode: char_u
            mode: vi_insert
            event: { edit: cutfromstart }
        }
    ]
}


# Alias
alias b = bash -ci
alias vim = nvim
alias v = nvim
alias t = tgpt --provider duckduckgo -m
alias shutd = shutdown --no-wall
alias lf = lfub
alias i3c = vim ~/.config/i3/config
alias ttt = tt -theme ~/.config/tt/themes/catppuccin-mocha -t 20

def h [] { history | reverse | fzf }

use ~/.cache/starship/init.nu
