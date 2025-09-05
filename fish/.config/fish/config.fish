if status is-login
    switch (uname)
        case Darwin
            source $__fish_config_dir/darwin.fish
    end

    # Make global Mise tools available in system PATH
    mise hook-env -s fish | source

    source ~/.cargo/env.fish

    fish_add_path -P ~/.local/share/bob/nvim-bin
    set -x EDITOR "nvim"
end

if status is-interactive
    set fish_greeting

    # Activate Mise for interactive shells
    mise activate fish | source

    zoxide init fish | source
    starship init fish | source

    source $__fish_config_dir/interactive.fish
end
