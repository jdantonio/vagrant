#===============================================================
#
# .profile || .bash_profile
#
# ALIASES AND FUNCTIONS
#
#===============================================================

#-------------------
# Detect OS
#-------------------

platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
  platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
  platform='mac'
elif [[ "$unamestr" == 'MINGW32_NT-6.1' ]]; then
  platform='windows'
fi

#-------------------
# Git Completion
#-------------------

## The default for Git Bash on Windows
export PS1='\[\033]0;$MSYSTEM:${PWD//[^[:ascii:]]/?}\007\]\n\[\033[32m\]\u@\h \[\033[33m\]\w$(__git_ps1)\[\033[0m\]\n$ '
if [[ $platform == 'linux' ]]; then
  #source /etc/bash_completion.d/git
  export PS1='\[\e]0;\w\a\]\n\[\e[0m\][\[\e[36m\]\t \[\e[32m\]\u \[\e[33m\]\w\[\e[32m\]$(__git_ps1 " (%s)")\[\e[0m\]]$ '
elif [[ $platform == 'mac' ]]; then
  if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
    export PS1='\[\e]0;\w\a\]\n\[\e[0m\][\[\e[36m\]\t \[\e[32m\]\u \[\e[33m\]\w\[\e[32m\]$(__git_ps1 " (%s)")\[\e[0m\]]\n$ '
  fi
  #elif [[ $platform == 'windows' ]]; then
  #export PS1='\[\033]0;$MSYSTEM:${PWD//[^[:ascii:]]/?}\007\]\n\[\033[32m\]\u@\h \[\033[33m\]\w$(__git_ps1)\[\033[0m\]\n$ '
fi

if [[ $platform == 'mac' ]]; then
  # mac-specific stuff
  export PATH=/usr/local/sbin:/usr/local/bin:$PATH:~/bin
  export COMMAND_MODE=unix2003
#elif [[ $platform == 'linux' ]]; then
  # linux-specific stuff
#elif [[ $platform == 'windows' ]]; then
  # windows-specific stuff
fi

#-------------------
# Enviro Vars
#-------------------

export EDITOR=vim
export HISTCONTROL=ignoredups

#-------------------
# Personnal Aliases
#-------------------

alias h='history'
alias which='type -a'
alias ..='cd ..'
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'
alias du='du -kh'       # Makes a more readable output.
alias df='df -kTh'
alias ff='find . -name'
alias psx='ps aux | grep'
alias stop="kill -9"

if [[ $platform == 'mac' ]]; then
  alias ls='ls -G'
elif [[ $platform == 'linux' ]]; then
  alias ls='ls --color=auto'
else
  alias ls='ls --color=auto'
fi
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

#alias clean='find . -name *.*~ -print0 | xargs -0 rm'
alias clean='find . -name *.swp -print0 | xargs -0 rm'
alias undos='find . -exec dos2unix \{\} \; -print'

alias got='git' # because I keep mistyping this
alias g='git'

alias v='vagrant'
v.go() {
  vagrant up
  vagrant ssh
}

if [[ $platform == 'linux' ]]; then
  alias gitg='git g'
  alias gitx='git g'
  alias open='nautilus'
  alias ack='ack-grep'
  alias tmax='terminator --fullscreen &'
fi

alias ackr='ack --type=ruby'
alias ackg='ack --type=go'
alias ackj='ack --type=javascript'

# Ruby development

alias be='bundle exec'
alias bc='bundle console'
alias bake='bundle exec rake'
alias baket='bundle exec rake -T'
alias baked='bundle exec rdebug rake'

alias rs='bundle exec rails server'
alias rc='bundle exec rails console'
alias rg='bundle exec rails generate'
alias rd='bundle exec rails dbconsole'

alias cuke='bundle exec cucumber'
alias spec='bundle exec rspec -fd --color'

export JRUBY_OPTS="-J-Xms2g -J-Xmx4g -Xcext.enabled=true"
alias jr='jruby --1.9 -S'

alias yard-graph="yard graph --dependencies --empty-mixins --full | dot -T png -o diagram.png"

re.bundle() {
  rm Gemfile.lock
  gem install bundler
  bundle install
}

re.bake() {
  rm Gemfile.lock
  gem install bundler
  bundle install
  bundle exec rake clean
  bundle exec rake compile
}

re.migrate() {
  bundle exec rake db:drop
  bundle exec rake db:create
  bundle exec rake db:migrate
  bundle exec rake db:seed
}

re.prepare() {
  re.migrate
  bundle exec rake db:test:prepare
}

if [[ $platform == 'mac' ]]; then
  rbx.setupbuild() {
    brew update
    brew tap homebrew/dupes
    brew install automake bison openssl llvm zlib
    brew upgrade
    rvm use system
    gem install bundler
    gem update
  }
fi

# JavaScript development

js.init() {
  npm init
  npm install grunt --save-dev
}

alias harmony='node --harmony'

if [[ $platform == 'mac' ]]; then

  alias gitx="open -a /Applications/GitX.app"

  alias vi="/Applications/MacVim.app/Contents/MacOS/vim"
  alias vim="/Applications/MacVim.app/Contents/MacOS/vim"

  update.stuff() {
    brew update
    brew tap homebrew/versions
    brew tap homebrew/dupes
    brew upgrade
    brew prune
    gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
    rvm get stable
    rvm cleanup all
    gem update --system
  }

  docker.reset() {
    boot2docker stop
    boot2docker delete
    boot2docker init
    boot2docker start
  }

  docker.start() {
    boot2docker start
    $(boot2docker shellinit)
  }

  docker.shell() {
    $(boot2docker shellinit)
  }

  [[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

  export DYLD_LIBRARY_PATH=/usr/local/mysql-5.1.73-osx10.6-x86_64/lib
  export PATH=$PATH:/usr/local/mysql/bin

  export GOROOT=/usr/local/go

elif [[ $platform == 'linux' ]]; then

  update.stuff() {
    sudo apt-get update
    sudo apt-get upgrade
    gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
    rvm get stable
    rvm cleanup all
    gem update --system
  }

  alias apt="sudo apt-get"

  docker.update() {
    wget -qO- https://get.docker.com/ | sh
  }

  [[ -s /usr/share/autojump/autojump.sh ]] && . /usr/share/autojump/autojump.sh

  export PATH=$PATH:$JAVA_HOME/bin

  export GOROOT=/opt/go

elif [[ $platform == 'windows' ]]; then

  alias gvim='"C:\Program Files (x86)\Vim\vim74\gvim.exe" &'

  export GOROOT=/c/go
fi

go.testem() {
  go test -v ./...
}

go.bundle() {
  go get -t ./...
}

export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:$GOPATH/bin

go.here() {
  here=/${PWD#*/}
  export GOPATH=$here
  export GOBIN=$here/bin
  export PATH=$PATH:$GOBIN
}

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

# RVM
# http://rvm.beginrescueend.com/
# http://everydayrails.com/2010/06/28/rvm-gemsets-rails3.html

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
