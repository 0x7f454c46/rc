#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias mount.vfat='mount -t vfat -o iocharset=utf8,rw,gid=100'
PS1='[\u@\h \W]\$ '

HISTSIZE=100000
HISTFILESIZE=100000
HISTCONTROL=erasedups
export EDITOR=vim
export SUDO_EDITOR=vim
export BROWSER=dwb
export PAGER="less"

# fix for urxvt, which is not known by ssh nodes in termcap
alias ssh="TERM=xterm ssh"

# 'pkgfile' package (.zsh)
[[ -f /usr/share/doc/pkgfile/command-not-found.bash ]] &&
	source /usr/share/doc/pkgfile/command-not-found.bash

## Less options
export LESS="--quit-if-one-screen --ignore-case --RAW-CONTROL-CHARS"
export LESS="${LESS} --chop-long-lines --no-init"
## Less colored output
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export LESSHISTFILE=/tmp/lesshst
export SUDO_ASKPASS=/usr/lib/ssh/ssh-askpass
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk # for Android building

## set console font in tty
# TODO: remove, when systemd start working as init system, not as a web-server
if [[ -z $DISPLAY ]] ; then
	setfont ter-u16b
fi

# echo date
echo "Date: $(date)"

# show fortune
fortune -a

# check window size after each command
# if necessary update the values LINES and COLUMNS
shopt -s checkwinsize

# play intro sound
[[ -f /usr/local/share/sounds/intro/supermario_pipe.wav ]] &&
	aplay /usr/local/share/sounds/intro/supermario_pipe.wav 2>/dev/null &
disown

[[ -f ~/.config/shell/include ]] &&
	source ~/.config/shell/include
