# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples


# ZAK DEFINED BEGINS

# gsettings set com.ubuntu.update-notifier show-livepatch-status-icon false

# conda config --set auto_activate_base false

# remove/comment "blacklist uvcvideo" to activate camera

export VISUAL=vim
export EDITOR="$VISUAL"

alias python='python3'
alias temp='watch -n 10 sensors'
alias camera='sudo gedit /etc/modprobe.d/blacklist.conf'
alias cameraon='sudo modprobe -i uvcvideo'
alias cameraoff='sudo modprobe -r uvcvideo'
alias shutdown='sudo shutdown now'
alias sd='shutdown'
alias SD='shutdown'
alias update='sudo apt update'
alias upgrade='sudo apt upgrade'

alias editbash='vi ~/.bashrc'
alias editvim='vi ~/.vimrc'
alias sourcebash='source ~/.bashrc'

findFile() {
  find "$2" -type f -name "$1"
}
alias ff='findFile'

# DIRECTORY
alias ..='cd ..'
alias ...='cd ../..'
alias dw='cd /home/user/Downloads'
alias dc='cd /home/user/Documents'

alias open='browse .'
alias lsa='ls -lrtas'
alias lss='ls -a'

# Appinventiv
export AWS_PROFILE=sandbox
alias ai='cd /home/user/Appinventiv'
alias nt='cd /home/user/Appinventiv/nextiles'

#GIT
alias g='git'
alias gl='git log'
alias gst='git status'
alias gdf='git diff'
alias gph='git push'
alias gpl='git pull'
alias gft='git fecth'
#alias gco='git checkout'
#alias gud='git checkout .'
alias grs='git reset HEAD .'
alias gss='git stash save'
alias gsa='git stash apply stash@{0}'

alias new='deactivate
cd
clear'

# alias db='sudo -u postgres psql'
#alias db='mysql -u root -p#welcome123'
alias code='code .'
alias runserver='./manage.py runserver 192.168.1.2:9000'
alias runlocal='./manage.py runserver 8000'
alias dshell='./manage.py shell'

alias venv='source ~/DjangoProjects/MiniProject/venv/bin/activate
cd ~/DjangoProjects/MiniProject/'
alias venvr='venv
runserver'
alias venvc='venv
code'
alias venvrc='venvc
runserver'
alias venvcr='venvrc'

alias jojo='source ~/DjangoProjects/jojo/venv/bin/activate
cd ~/DjangoProjects/jojo/'

alias prac='cd ~/Documents/python/
source ~/Documents/python/prac/bin/activate'  # commented out by conda initialize

alias bot='cd ~/Documents/python/bot
source venv/bin/activate'  # commented out by conda initialize

alias hero='cd ~/DjangoProjects/heroku/MiniProject
source venv/bin/activate'

#alias aws='cd ~/Documents/aws/keys'


alias aconda='conda activate'
alias dconda='conda deactivate'
alias jnotebook='jupyter notebook'

# Classplus/VIDU
alias vidu='cd ~/vidu/web_app'
alias viduapp='cd ~/vidu/mobile_app_android_basic'
alias vidudev='ssh root@internal.toprankers.com'
alias livechat='cd ~/vidu/livechat/
source venv_livechat/bin/activate'
alias viduchat='livechat'
alias chatserver='ssh root@52.66.245.225'
alias rcordova='cordova build browser && cordova run browser --target=firefox'



# ZAK DEFINED ENDS


# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

parse_git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (*\1)/'
}

if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    #PS1='\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1='\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\u\[\033[00m\]@\[\033[01;35m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;32m\]$(parse_git_branch)\[\033[00m\]\$ '
else
    #PS1='$\u@\h:\w\$ '
    PS1='\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;30m\]\u@\h\[\033[00m\]:\[\033[01;37m\]\w\[\033[00m\]\$'
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
