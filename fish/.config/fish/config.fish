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
            set repo_root (git rev-parse --show-toplevel 2>/dev/null)
            test -z "$repo_root"; and set repo_root $PWD
            set root_basename (basename $repo_root)

            if type -q jq
                set zellij_tab_id (zellij action current-tab-info --json 2>/dev/null | jq -r .tab_id)
            end

            nohup zellij action rename-tab "$root_basename $zellij_tab_id" >/dev/null 2>&1 &; disown 2>/dev/null
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
