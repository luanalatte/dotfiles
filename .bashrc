#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR=nvim
export HISTCONTROL=ignorespace:erasedups

# prompt
if [[ -f '/usr/share/git/git-prompt.sh' ]]; then
	source /usr/share/git/git-prompt.sh
	PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
else
	PS1='[\u@\h \W]\$ '
fi
# prompt end

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases

# .bash_aliases2 intended to be used as a private aliases file
[[ -f ~/.bash_aliases2 ]] && source ~/.bash_aliases2

# bash-completion
if command -v complete >/dev/null 2>&1; then 
	complete -cf sudo
	complete -F _command sudo
	if [[ -f '/usr/share/bash-complete-alias/complete_alias' ]]; then
		source /usr/share/bash-complete-alias/complete_alias
		complete -F _complete_alias "${!BASH_ALIASES[@]}"
	fi
fi
# bash-completion end

eval "$(ssh-agent -s)" > /dev/null

eval "$(starship init bash)"

command -v direnv >/dev/null 2>&1 && eval "$(direnv hook bash)"

