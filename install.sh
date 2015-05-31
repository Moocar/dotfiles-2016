#!/usr/bin/env bash

set -e

cd `dirname $0`
export DOTFILES=`pwd`

source $DOTFILES/install_functions.sh

update_submodules

create_ssh_config
link_with_backup .bashrc
link_with_backup .bash_profile
link_with_backup .bash_gpg
link_with_backup .gitconfig
link_with_backup .gitignore_global
link_with_backup .rvmrc
link_with_backup .tmux.conf
link_with_backup .ackrc
link_with_backup .mjolnir
link_with_backup .gnupg

mkdir -p "$HOME/bin"
link_with_backup bin/clj
link_with_backup bin/edit
link_with_backup bin/git-submodule-pull
link_with_backup bin/tab
link_with_backup bin/trunctail

mkdir -p "$HOME/.bash.d"

if [[ ! -d /Applications/Emacs.app ]]; then
    echo "XEmacs didn't get installed properly. Try running ./freshen.sh"
    exit 1
fi

EMACS_EXEC=emacs
if [[ `emacs -version` != "24" ]]; then
    EMACS_EXEC="/Applications/Emacs.app/Contents/MacOS/Emacs -nw"
    alias emacs="${EMACS_EXEC}"
    echo "Adding alias for command-line emacs"
    touch $HOME/.bash.d/emacs
    echo "alias emacs=\"${EMACS_EXEC}\"" >> $HOME/.bash.d/emacs
    echo ">> you might want to: alias emacs=\"${EMACS_EXEC}\""
fi

source $HOME/.bash.d/emacs

install_elpa
link_with_backup .emacs.d
link_with_backup .emacs
link_with_backup .emacs-custom.el
compile_local_emacs_lisp

write_home_path_file

if [[ "$USER" != "anthony" ]]; then
    unset_git_user
fi
