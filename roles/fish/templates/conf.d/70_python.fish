# Setup pyenv, a Python version switcher.
# Setup is based on the documentation, and on the output of `pyenv init -`.

set --global --export PYENV_ROOT $HOME/.pyenv
set --global --export PYENV_SHELL fish

fish_add_path --global $PYENV_ROOT/shims

# Add a function with the same name as the binary, in order for the `rehash`
# and `shell` commands to work properly, as these modify the current shell
# environment
function pyenv
    set command $argv[1]
    set -e argv[1]

    switch "$command"
        case rehash shell
            source (pyenv "sh-$command" $argv|psub)
        case '*'
            command pyenv "$command" $argv
    end
end
