#!/usr/bin/env fish

switch (uname)
case Darwin
    set ignored_packages hyprland
case '*'
    set ignored_packages aerospace skhd
end

for dir in ./*/
    set package (basename $dir)

    if contains $package $ignored_packages
        echo -e "\033[0;34mINFO: ignoring package $package\033[0m"
        continue
    end

    echo -e "\033[0;32mINFO: stowing package $package\033[0m"
    stow $package -t $HOME
end
