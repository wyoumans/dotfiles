# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#export ZSH_THEME="random"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want disable red dots displayed while waiting for completion
# DISABLE_COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/Users/william/.rvm/gems/ruby-1.9.3-p125/bin:/Users/william/.rvm/gems/ruby-1.9.3-p125@global/bin:/Users/william/.rvm/rubies/ruby-1.9.3-p125/bin:/Users/william/.rvm/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/git/bin:/usr/local/php5/bin:$HOME/.bin

function cdf () {
  CURRFOLDERPATH=$( /usr/bin/osascript <<"    EOT"
    tell application "Finder"
      try
        set currFolder to (folder of the front window as alias)
      on error
        set currFolder to (path to desktop folder as alias)
      end try
      POSIX path of currFolder
    end tell
    EOT
  )
  echo "cd to \"$CURRFOLDERPATH\""
  cd "$CURRFOLDERPATH"
}

function collapse_pwd {
  echo $(pwd | sed -e "s,^$HOME,~,")
}

function prompt_char {
  git branch >/dev/null 2>/dev/null && echo '±' && return
  hg root >/dev/null 2>/dev/null && echo '☿' && return
  echo '>'
}

function battery_charge {
  echo `$BAT_CHARGE` 2>/dev/null
}

function virtualenv_info {
  [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

function hg_prompt_info {
  hg prompt --angle-brackets "\
    < (%{$fg[blue]%}<branch>%{$reset_color%}>)\
    <@%{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
    %{$fg[red]%}<status|modified|unknown><update>%{$reset_color%}<
  patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
}

alias heroku="nocorrect heroku"
alias git="nocorrect git"
alias gitx="nocorrect gitx"
alias npm="nocorrect npm"
alias node="nocorrect node"
alias oo="open ."
alias nanoc="nocorrect nanoc"
alias gitignored="git ls-files -v | grep \"^[a-z]\""
alias lock="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
alias tmux="tmux -2 -u"
alias tmuxcopy="tmux show-buffer | tr -d '\n' | pbcopy"

rm () { mv $* ~/.Trash }
tm () { if [[ -z $* ]]; then tmux ls; else tmux attach-session -d -t $* || tmux new-session -s $*; fi }

PROMPT='
%{$fg[blue]%}%n%{$reset_color%}@%{$fg[cyan]%}%m%{$reset_color%}:%{$fg_bold[green]%}$(collapse_pwd)%{$reset_color%}$(hg_prompt_info)$(git_prompt_info)
$(virtualenv_info)$(prompt_char) '

ZSH_THEME_GIT_PROMPT_PREFIX=" ("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%})"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
[[ -s "$HOME/.zshrc.local" ]] && . "$HOME/.zshrc.local" # Load local ZSH config if it exists

alias pear="php /usr/lib/php/pear/pearcmd.php"
alias pecl="php /usr/lib/php/pear/peclcmd.php"

PATH=$PATH:$HOME/.rvm/bin:/usr/local/share/npm/bin # Add RVM & NPM to PATH for scripting

fortune | cowsay -f tux

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

#NVM
. ~/.nvm/nvm.sh
nvm use v0.10.22
