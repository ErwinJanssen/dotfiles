# Source: https://github.com/fish-shell/fish-shell/issues/3443#issuecomment-253838672
set -l clr_list (set -n | grep fish | grep color | grep -v __)
if test -n "$clr_list"
    set -l bclr (set_color normal)
    set -l bold (set_color --bold)
    printf "\n| %-38s | %-38s |\n" Variable Definition
    echo '|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯|'
    for var in $clr_list
        set -l def $$var
        set -l clr (set_color $def (cat /dev/null))
        or begin
            printf "| %-38s | %s%-38s$bclr |\n" "$var" (set_color --bold white --background=red) "$def"
            continue
        end
        printf "| $clr%-38s$bclr | $bold%-38s$bclr |\n" "$var" "$def"
    end
    echo '|________________________________________|________________________________________|'\n
end
