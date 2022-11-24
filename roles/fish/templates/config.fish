# Disable greeting message at start
set fish_greeting

# Preferred tools
set -gx EDITOR {{ editor }}
set -gx BROWSER {{ browser }}

# Prepend PATH with local bin directory
set -gx PATH ~/.local/bin/ $PATH

# Prepend PATH with the Flatpak bin directory
set -gx PATH /var/lib/flatpak/exports/bin $PATH

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

# Automatically merge the history after executing a command. This creates
# a global history that is shared between all fish sessions, and prevents
# entries from suddenly being "forgotten".
function global_history \
        --description "Merge history after every command." \
        --on-event fish_prompt
    history merge
end

# Use the cross-shell prompt Starship instead of custom `fish_prompt` function
starship init fish | source

# Start Sway on tty1
if [ (tty) = "/dev/tty1" ]
    # Send Sway's output to journald, retrieve with:
    # `journalctl --user --identifier sway`
    exec systemd-cat --identifier=sway sway
end
