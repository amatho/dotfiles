#!/usr/bin/env fish

switch (uname)
case Darwin
    set ignored_packages hyprland sway uwsm
case '*'
    set ignored_packages aerospace skhd
end

set fold_packages nvim zsh

for dir in ./*/
    set package (basename $dir)

    if contains $package $ignored_packages
        echo -e "\033[0;34mINFO: ignoring package $package\033[0m"
        continue
    end

    if contains $package $fold_packages
        echo -e "\033[0;32mINFO: stowing package $package\033[0m"
        stow $package -t $HOME
    else
        echo -e "\033[0;32mINFO: stowing package $package without folding\033[0m"
        stow $package -t $HOME --no-folding
    end
end
