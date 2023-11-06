# Setup pyenv, a Python version switcher

set --global --export PYENV_ROOT $HOME/.pyenv
set --global fish_user_paths $PYENV_ROOT/bin $fish_user_paths

pyenv init - | source
