set fish_greeting

switch (uname)
    case Darwin
        source $__fish_config_dir/darwin.fish
end

# Activate mise
mise activate fish | source
mise hook-env -s fish | source

source ~/.cargo/env.fish

fish_add_path -aP ~/.local/share/bob/nvim-bin

zoxide init fish --cmd cd | source
starship init fish | source

if status is-interactive
    source $__fish_config_dir/interactive.fish
end
