if status is-login
    test "$(uname -s)" = "Darwin"; and /opt/homebrew/bin/brew shellenv | source

    # Make global Mise tools available in system PATH
    mise hook-env -s fish | source

    test -e ~/.cargo/env.fish; and source ~/.cargo/env.fish

    functions -q autostart-hyprland; and autostart-hyprland
end

if status is-interactive
    set fish_greeting
    type -q nvim; and set -x EDITOR "nvim"

    if not set -q ZELLIJ; and test "$TERM_PROGRAM" = "ghostty"
        zellij
    else if set -q ZELLIJ
        function __zellij_update_tab_name --on-variable PWD --description "Rename Zellij tab to git repo root"
            set -l git_root (git rev-parse --show-toplevel 2>/dev/null)
            test -z "$git_root"; and set git_root $PWD
            set -l root_basename (basename $git_root)
            nohup zellij action rename-tab $root_basename >/dev/null 2>&1 &; disown 2>/dev/null
        end

        __zellij_update_tab_name
    end

    # Activate Mise for interactive shells
    mise activate fish | source

    zoxide init fish | source
    starship init fish | source

    set --global fish_key_bindings fish_vi_key_bindings

    source $__fish_config_dir/aliases.fish
    source $__fish_config_dir/theme.fish
end
