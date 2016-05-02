alias reload!='. ~/.zshrc'

# Search "man zshall(1)" using "zman <arg>"
zman() {
  PAGER="less -g -s '+/^       "$1"'" man zshall
}

# Pimp my 'ls'
export LS_OPTIONS='--human-readable --size --classify --group-directories-first --color=auto --time-style=+"%Y.%m.%d %H:%M" -F'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
alias ll='ls -l $LS_OPTIONS'
alias la='ls -la $LS_OPTIONS'

alias grep='grep --color=tty -d skip'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano PKGBUILD'
alias fixit='sudo rm -f /var/lib/pacman/db.lck'
alias update='yaourt -Syua'
alias con='nano $HOME/.i3/config'
alias comp='nano $HOME/.config/compton.conf'
alias inst='sudo pacman -S'
alias mirrors='sudo pacman-mirrors -g'
