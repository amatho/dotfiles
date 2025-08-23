#!/usr/bin/env fish

for dir in ./*/
    set package (basename $dir)
    if test "$package" = "aerospace"; or test "$package" = "skhd"
        continue
    end

    stow $package -t $HOME
end
