if status is-login
    test "$(uname)" = "Darwin"; and source $__fish_config_dir/darwin.fish

    # Make global Mise tools available in system PATH
    mise hook-env -s fish | source

    test -e ~/.cargo/env.fish; and source ~/.cargo/env.fish

    functions -q autostart-hyprland; and autostart-hyprland
end

if status is-interactive
    set fish_greeting

    # Activate Mise for interactive shells
    mise activate fish | source

    zoxide init fish | source
    starship init fish | source

    fish_add_path -P ~/.local/share/bob/nvim-bin
    set -x EDITOR "nvim"

    source $__fish_config_dir/interactive.fish
    source $__fish_config_dir/theme.fish
end
