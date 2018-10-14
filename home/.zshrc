# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="cobalt2"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

source $ZSH/oh-my-zsh.sh

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/git/bin:/usr/local/php5/bin:$HOME/.bin:$PATH

# You may need to manually set your language environment
export LANG=en_US.UTF-8

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

alias git="nocorrect git"
alias nah="git reset --hard && git clean -fd"

alias oo="open ."
alias gitignored="git ls-files -v | grep \"^[a-z]\""
alias lock="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
alias tmux="tmux -2 -u"
alias tmuxcopy="tmux show-buffer | tr -d '\n' | pbcopy"
alias copyssh="pbcopy < $HOME/.ssh/id_rsa.pub"
alias reloadcli="source $HOME/.zshrc"
alias pear="php /usr/lib/php/pear/pearcmd.php"
alias pecl="php /usr/lib/php/pear/peclcmd.php"

alias art="php artisan"
alias tinker="php artisan tinker"

# Homestead
alias edithomestead='subl ~/.Homestead/Homestead.yaml'
alias updatehomestead='cd ~/.Homestead && vagrant box update && git pull origin master'

[[ -s "$HOME/.zshrc.local" ]] && . "$HOME/.zshrc.local" # Load local ZSH config if it exists

PATH=$PATH:/usr/local/share/npm/bin # Add NPM to PATH for scripting
