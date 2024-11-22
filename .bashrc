#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [[ -f '/usr/share/git/git-prompt.sh' ]]; then
	source /usr/share/git/git-prompt.sh
	PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
else
	PS1='[\u@\h \W]\$ '
fi

EDITOR=nvim
HISTCONTROL=ignorespace:erasedups

complete -cf sudo
complete -F _command sudo

[[ -f '/usr/share/bash-complete-alias/complete_alias' ]] && source /usr/share/bash-complete-alias/complete_alias

source ~/.bash_aliases

[[ -f '/usr/share/bash-complete-alias/complete_alias' ]] && complete -F _complete_alias "${!BASH_ALIASES[@]}"

eval "$(ssh-agent -s)" > /dev/null

command -v direnv >/dev/null 2>&1 && eval "$(direnv hook bash)"
