export COLOR_NC='\033[0m' # No Color
export COLOR_WHITE='\033[1;37m'
export COLOR_BLACK='\033[0;30m'
export COLOR_BLUE='\033[0;34m'
export COLOR_LIGHT_BLUE='\033[1;34m'
export COLOR_GREEN='\033[0;32m'
export COLOR_LIGHT_GREEN='\033[1;32m'
export COLOR_CYAN='\033[0;36m'
export COLOR_LIGHT_CYAN='\033[1;36m'
export COLOR_RED='\033[0;31m'
export COLOR_LIGHT_RED='\033[1;31m'
export COLOR_PURPLE='\033[0;35m'
export COLOR_LIGHT_PURPLE='\033[1;35m'
export COLOR_BROWN='\033[0;33m'
export COLOR_YELLOW='\033[1;33m'
export COLOR_GRAY='\033[0;30m'
export COLOR_DARK_GRAY='\033[1;30m'
export COLOR_LIGHT_GRAY='\033[0;37m'

alias ls='ls -G'  # OS-X SPECIFIC - the -G command in OS-X is for colors, in Linux it's no groups
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export TERM=xterm-color
export CLICOLOR=1
export PS1="\[${COLOR_BLUE}\]\u@\h \[${COLOR_GREEN}\]\w > \[${COLOR_NC}\]"

__git_ps1(){ echo ""; }

export LESS="${LESS} -I"

if [ -f /usr/bin/git-completion.sh ]; then
 . /usr/bin/git-completion.sh
fi

git_dirty_flag() {
 if [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit" ]]; then
   echo -e "${COLOR_RED}"
 else
   echo -e "${COLOR_BLUE}"
 fi
}

prompt_func() {
   previous_return_value=$?;
   prompt="\[${COLOR_BLUE}\]\u@\h \[${COLOR_GREEN}\]\w\[$(git_dirty_flag)\]$(__git_ps1) \[${COLOR_NC}\]"
   if test $previous_return_value -eq 0
   then
       PS1="${prompt}> "
   else
       PS1="${prompt}\[${COLOR_RED}\]> \[${COLOR_NC}\]"
   fi
}
export PROMPT_COMMAND=prompt_func

alias ll="ls -l"
alias lo="ls -o"
alias lh="ls -lh"
alias la="ls -la"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias grp="grep --exclude=.git -R"

function rm () {
  local path
  for path in "$@"; do
    # ignore any arguments
    if [[ "$path" = -* ]]; then :
    else
      local dst=${path##*/}
      # append the time if necessary
      while [ -e ~/.Trash/"$dst" ]; do
        dst="$dst "$(date +%H-%M-%S)
      done
      mv "$path" ~/.Trash/"$dst"
    fi
  done
}

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
