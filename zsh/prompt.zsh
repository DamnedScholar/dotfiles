autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

git_branch() {
  echo $($git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_dirty() {
  if $(! $git status -s &> /dev/null)
  then
    echo ""
  else
    if [[ $($git status --porcelain) == "" ]]
    then
      echo " on %{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}"
    else
      echo " on %{$fg_bold[red]%}$(git_prompt_info)%{$reset_color%}"
    fi
  fi
}

git_prompt_info () {
 ref=$($git symbolic-ref HEAD 2>/dev/null) || return
# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
 echo "${ref#refs/heads/}"
}

unpushed () {
  $git cherry -v @{upstream} 2>/dev/null
}

need_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo ""
  else
    echo " with %{$fg_bold[magenta]%}unpushed%{$reset_color%} "
  fi
}

ruby_version() {
  if (( $+commands[rbenv] ))
  then
    echo "$(rbenv version | awk '{print $1}')"
  fi

  if (( $+commands[rvm-prompt] ))
  then
    echo "$(rvm-prompt | awk '{print $1}')"
  fi
}

rb_prompt() {
  if ! [[ -z "$(ruby_version)" ]]
  then
    echo "%{$fg_bold[yellow]%}$(ruby_version)%{$reset_color%} "
  else
    echo ""
  fi
}

directory_check_symlinks() {
  export ROOTDIR=/
  # Clear directory stack for the purpose of the subshell
  dirs -c
  # While loop to iterate pushd until ~0 is equal to / or ~.
  until [[ ~0 == $ROOTDIR || ~0 == $HOME ]]; do
    pushd -q ..
  done

  # Store the number of directories in the stack and the list in an array.
  dirs_size=$(dirs -v | wc -l)
  dirs_names=$(dirs)

  #dirs_names=("${(@)${(s: :)dirs_names}}")

  #echo "$dirs_names: "

  # Check each stack entry for symbolic links and add the directory name to the prompt path.
  for (( i = 1; i <= $dirs_size; i++ )); do
    #echo "$dirs_names[(w)$i] >"
    dir_here=$dirs_names[(w)$i]

    if ! [ -f "$dir_here" ]; then
      echo "$dir_here is a symlink"
    else
      echo "$dir_here is not a symlink"
    fi
  done
}

directory_name() {
  echo "%{$fg_bold[cyan]%}${PWD/#$HOME/~}%\/%{$reset_color%}"
}

user() {
  echo "%{$fg_bold[green]%}%n%{$reset_color%}"
}

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '☿' && return
    echo ''
}

export PROMPT=$'\n$(rb_prompt)in $(prompt_char)$(directory_check_symlinks)$(git_dirty)$(need_push) as $(user)\n› '
set_prompt () {
  export RPROMPT="%{$fg_bold[cyan]%}%{$reset_color%}"
}

precmd() {
  title "zsh" "%m" "%55<...<%~"
  set_prompt
}
