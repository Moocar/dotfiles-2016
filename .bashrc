# Terminal colors
        RED="\[\033[0;31m\]"
     ORANGE="\[\033[0;33m\]"
     YELLOW="\[\033[0;33m\]"
      GREEN="\[\033[0;32m\]"
       BLUE="\[\033[0;34m\]"
  LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
      WHITE="\[\033[1;37m\]"
 LIGHT_GRAY="\[\033[0;37m\]"
 COLOR_NONE="\[\e[0m\]"

# Used later (maybe in .bash_local) to determine if this is an
# interactive shell; see http://www.gnu.org/software/bash/manual/html_node/Is-this-Shell-Interactive_003f.html
case "$-" in
*i*)	INTERACTIVE_SHELL="true" ;;
*)	: ;;
esac

# Basic environment
export TERM=xterm-256color
export PS1="${BLUE}\h:\W \$${COLOR_NONE} "
export EDITOR=/usr/bin/nano

# My path
if [[ -e "$HOME/.path" ]]; then
    path=""
    while read -r; do
        if [[ ! -z "$path" ]]; then path="$path:"; fi
        path="$path$REPLY"
    done < "$HOME/.path"
    export PATH="$path"
fi


# My aliases
if [[ "$(uname)" == "Darwin" ]]; then
    alias l="ls -FG"
    alias ls="ls -FG"
    alias ll="ls -lhFG"
    alias la="ls -ahFG"
    alias lal="ls -lahFG"
    alias d="pwd && echo && ls -FG"
else
    alias l="ls --color -F"
    alias ls="ls --color -F"
    alias ll="ls --color -lhF"
    alias la="ls --color -ahF"
    alias lal="ls --color -lahF"
    alias d="pwd && echo && ls --color -F"
fi

alias rm='rm -i'

alias beep="echo -e '\a'"

alias pgrep='ps aux | grep'

alias w="cd ~/workspace"

# for Perl5 / CPAN
if [ -e /opt/local/lib/perl5 ]; then
    export PERL5LIB="/opt/local/lib/perl5/5.8.8:/opt/local/lib/perl5/site_perl/5.8.8:/opt/local/lib/perl5/vendor_perl/5.8.8"
fi

if [ -e /Applications/TrueCrypt.app/Contents/MacOS/TrueCrypt ]; then
    alias truecrypt="/Applications/TrueCrypt.app/Contents/MacOS/TrueCrypt -t"
fi

if which open > /dev/null; then
    alias e="open -a Emacs.app"
elif which emacs > /dev/null; then
    alias e="emacs"
else
    alias e="nano"
fi

alias rsync="rsync -P -vaz --rsh=ssh"

# Local system stuff
if [ -e ~/.bash_local ]; then
    source ~/.bash_local
fi

# cdargs
if [ -f /opt/local/etc/profile.d/cdargs-bash.sh ]; then
    source /opt/local/etc/profile.d/cdargs-bash.sh
fi

# Git autocompletion
if [ -f /opt/local/etc/bash_completion ]; then
      source /opt/local/etc/bash_completion
fi

# Java on OS X
if [[ -f /usr/libexec/java_home ]]; then
    export JAVA_HOME="$(/usr/libexec/java_home -v 1.7)"
fi

## GPG Agent
## From http://sudoers.org/2013/11/05/gpg-agent.html
GPG_AGENT=$(which gpg-agent)
GPG_TTY=`tty`
export GPG_TTY
if [[ -f ${GPG_AGENT} && -e "${HOME}/.bash_gpg" ]]; then
    source "${HOME}/.bash_gpg"
fi

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh

#### history ####

HISTSIZE=100000
HISTFILESIZE=100000
HISTIGNORE=exit:l:la:ll:lsd:pwd:..:...:....:.....
HISTCONTROL=ignoredups

# Append to the Bash history file, rather than overwriting it
shopt -s histappend
