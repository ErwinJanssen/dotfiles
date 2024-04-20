# Disable greeting message at start
set fish_greeting

# Preferred tools
set --global --export BROWSER {{ browser }}

set --global --export SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket

# Custom key bindings
function fish_user_key_bindings
    # ctrl-del
    bind \e\[3\;5~ kill-word

    # ctrl-backspace
    bind \cH backward-kill-word
end
