set __fish_git_prompt_show_informative_status 'yes'
set __fish_git_prompt_showcolorhints 'yes'

function fish_prompt --description 'Write out the prompt'
    set --local exit_code $status

    echo -ns (set_color $fish_color_user) $USER
    echo -ns (set_color normal) @
    echo -ns (set_color $fish_color_host) (prompt_hostname)
    echo -ns (set_color $fish_color_cwd) " " (prompt_pwd)
    echo -ns (set_color normal)

    if functions --query __fish_vcs_prompt
        echo -ns (__fish_vcs_prompt)
    end

    if test $exit_code -eq 0
        set_color normal
    else
        set_color blue
    end
    echo -ns "> "

end
