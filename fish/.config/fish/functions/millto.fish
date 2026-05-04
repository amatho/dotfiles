function millto
    set cap_args
    for arg in $argv[2..]
        set first_char (string sub -s 1 -l 1 $arg)
        set first_char_upper (string upper $first_char)
        set rest (string sub -s 2 $arg)
        set -a cap_args "$first_char_upper$rest"
    end
    set selector_inner (string join "*" $cap_args)
    set selector "*$selector_inner*Test"
    CI=true ./mill "$argv[1].test.testOnly" $selector
end
