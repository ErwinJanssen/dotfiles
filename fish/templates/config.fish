# Disable greeting message at start
set fish_greeting

# Preferred tools
set -gx EDITOR {{ editor }}
set -gx BROWSER {{ browser }}

# Prepend PATH with local bin directory
set -gx PATH ~/.local/bin/ $PATH

# Make `fzf`, the fuzzy finder, always use `fd` instead of `find`
set -gx FZF_DEFAULT_COMMAND "fd --type file --follow --hidden --exclude .git"
set -gx FZF_DEFAULT_OPTS "
    --ansi
    --color=fg+:{{ ui.search.selected.foreground }}
    --color=bg+:-1
    --color=hl+:{{ ui.search.selected.match }}
    --color=bg:-1
    --color=hl:{{ ui.search.item.match }}
    --color=prompt:{{ ui.search.input.foreground }}
    --color=pointer:{{ ui.search.selected.foreground }}
    --color=marker:{{ ui.search.selected.match }}
"

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
