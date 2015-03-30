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

mkdir -p "$HOME/bin"
link_with_backup bin/clj
link_with_backup bin/edit
link_with_backup bin/git-submodule-pull
link_with_backup bin/tab
link_with_backup bin/trunctail

link_with_backup .emacs.d
install_elpa
link_with_backup .emacs
link_with_backup .emacs-custom.el
compile_local_emacs_lisp

write_home_path_file

if [[ "$USER" != "anthony" ]]; then
    unset_git_user
fi
