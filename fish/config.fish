set fish_greeting

# Activate mise
mise activate fish | source
mise hook-env -s fish | source

# Init starship
starship init fish | source

switch (uname)
    case Darwin
        source $__fish_config_dir/darwin.fish
end

if status is-interactive
    source $__fish_config_dir/interactive.fish
end
