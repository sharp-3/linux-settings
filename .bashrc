#!/bin/bash

# linux version
echo "   Kernel: $(uname --kernel-name)"
echo " HostName: $(uname --nodename)"
echo "  Release: $(uname --kernel-release)"
echo "  Version: $(uname --kernel-version)"
echo "  Machine: $(uname --machine)"
echo "Processor: $(uname --processor)"
echo " Platform: $(uname --hardware-platform)"
echo "       OS: $(uname --operating-system)"

# bash_version
echo "    Shell: $0 $BASH_VERSION"
echo "       \$\$: $$"
echo "    \$HOME: $HOME"
echo "    \$LANG: $LANG"

# history settings
shopt -s histappend
HISTCONTROL=ignoredups
HISTSIZE=1000
HISTFILESIZE=2000

# shopt settings
shopt -u autocd
shopt -u cdable_vars
shopt -u cdspell
shopt -s checkwinsize
shopt -u dirspell

# color prompt
case "$TERM" in 
	xterm-color|*-256color) color_prompt=yes;;
esac

## auto
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    export COLORTERM=truecolor
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

## force
if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		color_prompt=yes
	else
		color_prompt=
	fi
fi

unset color_prompt force_color_prompt

case "$TERM" in
	xterm*|rxvt*) PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1" ;;
	*) ;;
esac

# less settings
LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
LESS='-R --no-init --quit-if-one-screen'

# alias settings
if [ -e ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

if [ -e ~/.cargo/env ]; then
	. ~/.cargo/env
fi

if [ -e ~/.programs/env ]; then
	. ~/.programs/env
fi

cache_dir="/run/user/$(id -u)/cache"
mkdir -p $cache_dir
if [ ! -L $HOME/.cache ];then
	rm -r $HOME/.cache
	ln -s $cache_dir $HOME/.cache
fi
unset cache_dir
