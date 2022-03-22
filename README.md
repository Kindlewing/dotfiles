# Dotfiles - Managed with GNU Stow

## Installation
Note: SystemsCrafters has a fantastic resource on GNU Stow linked [here](https://systemcrafters.net/managing-your-dotfiles/using-gnu-stow/)
- Make sure you have stow installed
  - This package should be available on most unix based operating systems and can be installed with `sudo apt install stow`
- clone this repo to .dotfiles within your home directory
  - `git clone git@github.com:Kindlewing/dotfiles.git ~/.dotfiles`
- run `stow .` from within the `.dotfiles` repo you just cloned
  - `cd ~/.dotfiles`
  - `stow .`

