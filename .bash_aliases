#
# ~/.bash_aliases
#

# Allow aliases after sudo
alias sudo='sudo '

# doas as sudo
if command -v doas >/dev/null 2>&1; then
    alias sudo='doas '
    alias sudoedit='doas rnano'
fi

alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -la'
alias lla='ls -la'

alias grep='grep --color=auto'

alias vim='nvim'

alias dotfiles="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

# Creates a .envrc to run nix-direnv
setup-nix-direnv() {
    [[ ! -f '.envrc' ]] && echo -e "source \$HOME/.nix-profile/share/nix-direnv/direnvrc\n\nuse nix" > .envrc || echo ".envrc already exists."
}

# Modifies permissions to allow Custom CSS and JS extension to modify vscode.
vscode-customize() {
    sudo chown -R $(whoami) "$(which code)"
    sudo chown -R $(whoami) /opt/visual-studio-code
}

# Sorts GNOME desktop entries alphabetically
gnome-sort() {
    gsettings set org.gnome.shell app-picker-layout "[]" && echo 'Sorted. Restart GNOME session for changes to take effect.'
}

# Shorthands`
alias ':q'='exit'
alias '..'='cd ..'
alias g='git'
alias artisan='php artisan'
