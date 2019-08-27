# Disable greeting message at start
set fish_greeting

# Preferred tools
set -gx EDITOR {{ editor }}
set -gx BROWSER {{ browser }}

# Prepend PATH with local bin directory
set -gx PATH ~/.local/bin/ $PATH

# Make `fzf`, the fuzzy finder, always use `fd` instead of `find`
set -gx FZF_DEFAULT_COMMAND "fd --type file --follow --hidden --exclude .git --color always"
set -gx FZF_DEFAULT_OPTS "--ansi"

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

# Enable FZF key bindings if available
if functions --query fzf_key_bindings
    fzf_key_bindings
end

# Start Sway on tty1
if [ (tty) = "/dev/tty1" ]
    exec sway
end
