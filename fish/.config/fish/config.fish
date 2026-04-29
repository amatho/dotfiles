if status is-login
    test "$(uname -s)" = "Darwin"; and /opt/homebrew/bin/brew shellenv | source

    # Make global Mise tools available in system PATH
    mise hook-env -s fish | source

    test -e ~/.cargo/env.fish; and source ~/.cargo/env.fish

    functions -q autostart-compositor; and autostart-compositor
end

if status is-interactive
    set fish_greeting
    type -q nvim; and set -x EDITOR "nvim"

    if test "$TERM_PROGRAM" = "ghostty"
        tmux
    end

    # Activate Mise for interactive shells
    mise activate fish | source

    zoxide init fish | source
    starship init fish | source

    set --global fish_key_bindings fish_vi_key_bindings

    source $__fish_config_dir/aliases.fish
    source $__fish_config_dir/theme.fish
end
