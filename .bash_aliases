#
# ~/.bash_aliases
#

# Allow aliases after sudo
alias sudo='sudo '

alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -la'
alias lla='ls -la'

alias grep='grep --color=auto'

alias vim='nvim'

alias dotfiles="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

setup-nix-direnv() {
    [[ ! -f '.envrc' ]] && echo -e "source \$HOME/.nix-profile/share/nix-direnv/direnvrc\n\nuse nix" > .envrc || echo ".envrc already exists."
}

# Shorthands`
alias ':q'='exit'
alias '..'='cd ..'
alias g='git'
alias artisan='php artisan'
