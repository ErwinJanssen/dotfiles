#======================================
# Generic settings
#======================================
# {{{

# Disable greeting message at start
set fish_greeting

# }}}

#======================================
# Keybindings
#======================================
# {{{

function fish_user_key_bindings
    # ctrl-del
    bind \e\[3\;5~ kill-word

    # ctrl-backspace
    bind \cH backward-kill-word
end

# }}}

#======================================
# Start Sway on tty1
#======================================
# {{{

if [ (tty) = /dev/tty1 ]
    # Send Sway's output to journald, retrieve with:
    # `journalctl --user --identifier sway`
    exec systemd-cat --identifier=sway sway
end

# }}}
