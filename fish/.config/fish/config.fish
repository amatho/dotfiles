if status is-login
    test "$(uname -s)" = "Darwin"; and /opt/homebrew/bin/brew shellenv | source

    # Make global Mise tools available in system PATH
    mise hook-env -s fish | source

    test -e ~/.cargo/env.fish; and source ~/.cargo/env.fish

    functions -q autostart-hyprland; and autostart-hyprland
end

if status is-interactive
    set fish_greeting

    if not set -q ZELLIJ
        zellij
    end

    # Activate Mise for interactive shells
    mise activate fish | source

    zoxide init fish | source
    starship init fish | source

    fish_add_path -P ~/.local/share/bob/nvim-bin
    set -x EDITOR "nvim"

    set --global fish_key_bindings fish_vi_key_bindings

    source $__fish_config_dir/aliases.fish
    source $__fish_config_dir/theme.fish
end
