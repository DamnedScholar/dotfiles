alias reload!='. ~/.zshrc'

# Search "man zshall(1)" using "zman <arg>"
zman() {
  PAGER="less -g -s '+/^       "$1"'" man zshall
}
