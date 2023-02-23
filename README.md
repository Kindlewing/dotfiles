# Dotfiles managed with Dotdrop

# Getting started

---

Clone this repository

```bash
git clone git@github.com:Kindlewing/dotfiles.git ~/.dotfiles/
```

Change into the newly clone dotfiles directory

```bash
cd ~/.dotfiles/
```

Run `./dotdrop.sh install -p <profile-name>` to install the dotfiles

# Managing dotfiles

---

To manage your dotfiles in the future, `dotdrop import -p <profile-name> <dotfile-path>` is your friend.

Note 📔: dotdrop comes with this repository as a submodule, so the actual dotdrop command will be `./dotdrop.sh install <dotfile-path>`
