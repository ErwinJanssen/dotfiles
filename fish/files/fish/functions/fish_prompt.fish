set __fish_git_prompt_show_informative_status 'yes'
set __fish_git_prompt_showcolorhints 'yes'

function fish_prompt --description 'Write out the prompt'
    # Store the exit code as the first action, as this will be overwritten by
    # the echo commands.
    set --local exit_code $status

    # If the user is on its local machine, there is no need to display the user
    # or name. Instead, only set this when the prompt is used in an SSH
    # connection.
    if set --query SSH_CONNECTION
        echo -ns (set_color $fish_color_user) $USER
        echo -ns (set_color normal) @
        echo -ns (set_color $fish_color_host) (prompt_hostname)
        echo -ns " "
    end

    # Show the current working directory and reset the color to normal.
    echo -ns (set_color $fish_color_cwd) (prompt_pwd)
    echo -ns (set_color normal)

    # If available, show version control information.
    if functions --query __fish_vcs_prompt
        echo -ns (__fish_vcs_prompt)
    end

    # Start a new line for the prompt
    echo

    # If the last command exited with a failure, color the prompt red.
    if test $exit_code -eq 0
        set_color normal
    else
        set_color red
    end
    echo -ns "» "

end
