# Dotfiles - Managed with GNU Stow

## Dependencies
This repository uses [AstroVim](https://github.com/kabinspace/AstroVim) as the Neovim configuration.

#### Note:
    - The AstroVim config that this repository uses is NOT a submodule, so running :AstroUpdate as specified in the documentation above will not work 
## Installation
- Make sure you have stow installed
  - This package should be available on most unix based operating systems and can be installed with `sudo apt install stow`
- clone this repo to .dotfiles within your home directory
  - `git clone --recursive git@github.com:Kindlewing/dotfiles.git ~/.dotfiles`
- run `stow .` from within the `.dotfiles` repo you just cloned
  - `cd ~/.dotfiles`
  - `stow .`

## Neovim Setup
`nvim +PackerSync` to install the plugins

reload nvim 
