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

if command -v complete >/dev/null 2>&1; then 
	complete -cf sudo
	complete -F _command sudo
fi

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

[[ -f '/usr/share/bash-complete-alias/complete_alias' ]] && source /usr/share/bash-complete-alias/complete_alias

[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases

[[ -f '/usr/share/bash-complete-alias/complete_alias' ]] && complete -F _complete_alias "${!BASH_ALIASES[@]}"

eval "$(ssh-agent -s)" > /dev/null

command -v direnv >/dev/null 2>&1 && eval "$(direnv hook bash)"
