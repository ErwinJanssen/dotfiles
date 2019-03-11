set __fish_git_prompt_show_informative_status 'yes'
set __fish_git_prompt_showcolorhints 'yes'

function fish_prompt --description 'Write out the prompt'
    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end

    if not set -q __fish_prompt_cwd
        set -g __fish_prompt_cwd (set_color $fish_color_cwd)
    end

    echo -ns "$USER" @ (prompt_hostname)
    echo -ns " $__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal"

    if functions -q __fish_vcs_prompt
        echo -ns (__fish_vcs_prompt)
    end
    echo -ns "$__fish_prompt_normal> "
end
