# Anthony's Dotfiles

_Note, this is a fork of Stuart Sierra's [dotfiles](https://github.com/stuartsierra/dotfiles)_

## How it works?

### freshen.sh

`freshen.sh` is a script that installs common mac programs via brew.
It uses brew-cask to install applications that typically require a
download such as dropbox an chrome. It also installs python, Mjolnir
and configures it

### install.sh

`install.sh` is a script that performs the following:
- update and download submodules (contents is emacs packages)
- setup .ssh/config and known_hosts
- setup home directory hidden config files (e.g .bashrc) by creating
  symlinks back to this directory
- Setup ~/bin/ directory for programs
- setup emacs command line alias
- install emacs packages using emacs `package`
- symlink emacs home directory configuration
- byte-compile emacs for fast startup
