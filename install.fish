#!/usr/bin/env fish

set darwin_packages aerospace fish ghostty git helix ideavim jj nvim skhd starship wezterm zellij zsh
set linux_packages fish ghostty git helix ideavim jj nvim starship wezterm zellij zsh

switch (uname)
case Darwin
    set is_darwin
end

for dir in ./*/
    set package (basename $dir)

    if not contains $package $darwin_packages; and not contains $package $linux_packages
        echo "WARN: Unknown package $package. Maybe update install script?"
        continue
    else if set -q is_darwin; and not contains $package $darwin_packages
        continue
    else if not set -q is_darwin; and not contains $package $linux_packages
        continue
    end

    echo "INFO: stowing package $package"
    stow $package -t $HOME
end
