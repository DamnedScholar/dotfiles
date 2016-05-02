alias reload!='. ~/.zshrc'

# Search "man zshall(1)" using "zman <arg>"
zman() {
  PAGER="less -g -s '+/^       "$1"'" man zshall
}

# Pimp my 'ls'
#export LS_OPTIONS='--human-readable --size --classify --group-directories-first --color=auto --time-style=+"%Y.%m.%d %H:%M"'
#export LS_OPTIONS='-hsF --group-directories-first --color=auto --time-style=+"%Y.%m.%d %H:%M"'
eval "`dircolors`"
alias ls='ls -ahsF --group-directories-first --color=auto --time-style=+"%Y.%m.%d %H:%M"'
alias ll='ls -l -hsF --group-directories-first --color=auto --time-style=+"%Y.%m.%d %H:%M"'
alias la='ls -la -hsF --group-directories-first --color=auto --time-style=+"%Y.%m.%d %H:%M"'

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
