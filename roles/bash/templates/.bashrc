# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

# Format of the primary prompt:
#
#   { username }@{ hostname } { path/to/cwd }
#   $
#
# The prompt starts with a newline to separate the prompt from the previous
# command output. This makes it easier to separate commands and their output
# when scrolling through the terminal.
PS1='\n'

# Since bash will often be used on remote systems, show the user, full
# hostname, and complete working directory.
PS1+='\u@\H \w'

# The input prompt is on a new line. This allows long path names to be
# displayed, and the prompt is visually always at the same location. The prompt
# itself is colored red if the previous command did not exit with error code 0,
# this is done with the `colored_prompt` function.
function colored_prompt()
{
    if [ "$?" != "0" ]
    then
        # Escape sequence for red foreground text
        printf "\e[0;31m"
    fi

    # Show the prompt
    printf "» "

    # Restore foreground color to white
    printf "\e[0;37m"
}
PS1+='\n$(colored_prompt)'

# Control which commands are saved on the history list.
#
# ignoreboth: shorthand for `ignorespace` and `ignoredups`
#   ignorespace: Commands starting with a space are not saved.
#   ignoredups: Executing the same command multiple times only stores it once.
#
# erasedups:
#   Previous history entries matching the command will be removed before the
#   command is saved (prevents duplicates when searching through the history).
export HISTCONTROL=ignoreboth:erasedups
