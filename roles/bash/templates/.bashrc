# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Control which commands are saved on the history list.
#
# ignoreboth: shorthand for `ignorespace` and `ignoredups`
#   ignorespace: Commands starting with a space are not saved.
#   ignoredups: Executing the same command multiple times only stores it once.
#
# erasedups:
#   Previous history entries matching the command will be removed before the
#   command is saved (prevents duplicates when searching through the history).
export HISTCONTROL=ignoreboth:erasedups
