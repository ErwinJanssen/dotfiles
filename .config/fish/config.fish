# Disable greeting message at start
set fish_greeting

# Preferred tools
set -gx EDITOR nvim
set -gx BROWSER firefox

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
if type exa > /dev/null 2>&1
    # exa is a modern ls replacement
    function ls --description "List contents of directory"
        command exa $argv
    end
end



# Colors for git prompt
set yellow (set_color yellow)
set green (set_color green)
set red (set_color red)

# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

# Colors
set fish_color_autosuggestion 969896
set fish_color_cancel \x2dr
set fish_color_command c397d8
set fish_color_comment e7c547
set fish_color_cwd green
set fish_color_cwd_root red
set fish_color_end c397d8
set fish_color_error d54e53
set fish_color_escape bryellow\x1e\x2d\x2dbold
set fish_color_history_current \x2d\x2dbold
set fish_color_host normal
set fish_color_match \x2d\x2dbackground\x3dbrblue
set fish_color_normal normal
set fish_color_operator bryellow
set fish_color_param 7aa6da
set fish_color_quote b9ca4a
set fish_color_redirection 70c0b1
set fish_color_search_match bryellow\x1e\x2d\x2dbackground\x3dbrblack
set fish_color_selection white\x1e\x2d\x2dbold\x1e\x2d\x2dbackground\x3dbrblack
set fish_color_status red
set fish_color_user brgreen
set fish_color_valid_path \x2d\x2dunderline
set fish_pager_color_completion \x1d
set fish_pager_color_description B3A06D\x1eyellow
set fish_pager_color_prefix white\x1e\x2d\x2dbold\x1e\x2d\x2dunderline
set fish_pager_color_progress brwhite\x1e\x2d\x2dbackground\x3dcyan

# Start Sway on tty1
if [ (tty) = "/dev/tty1" ]
    exec sway
end
