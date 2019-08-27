set __fish_git_prompt_show_informative_status 'yes'
set __fish_git_prompt_showcolorhints 'yes'

function fish_prompt --description 'Write out the prompt'
    set --local exit_code $status

    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end

    if not set -q __fish_prompt_error
        set -g __fish_prompt_error (set_color red)
    end

    if not set -q __fish_prompt_cwd
        set -g __fish_prompt_cwd (set_color $fish_color_cwd)
    end

    echo -ns "$USER" @ (prompt_hostname)
    echo -ns " $__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal"

    if functions -q __fish_vcs_prompt
        echo -ns (__fish_vcs_prompt)
    end

    if test $exit_code -eq 0
        echo -ns "$__fish_prompt_normal> "
    else
        echo -ns "$__fish_prompt_error> "
    end

end
