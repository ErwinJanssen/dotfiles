# Disable greeting message at start
set fish_greeting

# Preferred tools
set -gx EDITOR {{ editor }}
set -gx BROWSER {{ browser }}

# Prepend PATH with local bin directory
set -gx PATH ~/.local/bin/ $PATH

# Custom key bindings
function fish_user_key_bindings
    # ctrl-del
    bind \e\[3\;5~ kill-word

    # ctrl-backspace
    bind \cH backward-kill-word
end

# Aliases
if command --search exa > /dev/null
    # exa is a modern ls replacement, use it if available
    function ls --description "List contents of directory"
        command exa $argv
    end
end

# Insert a new line before displaying the prompt. This separates the command
# prompt from the previous output.
function fishprompt_newline \
        --description "Insert a new line before displaying the prompt." \
        --on-event fish_prompt
    echo
end


# Start Sway on tty1
if [ (tty) = "/dev/tty1" ]
    exec sway
end
