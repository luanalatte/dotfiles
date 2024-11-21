#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

EDITOR=nvim
HISTCONTROL=ignorespace:erasedups

complete -cf sudo
complete -F _command sudo

source ~/.bash_aliases

eval "$(ssh-agent -s)" > /dev/null
