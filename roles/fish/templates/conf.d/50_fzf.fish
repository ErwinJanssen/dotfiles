# Configure FZF, the fuzzy finder, for Fish

# Make FZF always use `fd` instead of `find`
set --global --export FZF_DEFAULT_COMMAND "fd --type file --hidden --exclude .git --strip-cwd-prefix"

# Specify command for path completion when using CTRL-t
set --global --export FZF_CTRL_T_COMMAND "command fd --unrestricted --search-path \$dir --exclude .git"

# Configure colors
set --global --export FZF_DEFAULT_OPTS "
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

# Enable FZF key bindings if available
if functions --query fzf_key_bindings
    fzf_key_bindings
end
