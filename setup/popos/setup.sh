#!/bin/bash

# General setup for shell
target_dir="$HOME"
dot_dir="$PWD/dotfiles"

# Clean old symlinks and directories

# Link dotfiles
ln -sf "$dot_dir/zsh/.zshrc" "$target_dir/.zshrc"

# Standard installers
sudo apt update
sudo apt install eza
sudo apt install fd-find
sudo apt install fzf
sudo apt install starship
sudo apt install wezterm-nightly
sudo apt install zoxide

# Change shell to zsh
chsh -s $(which zsh)

# Source zsh in case we are rerunning the setup
exec /bin/zsh
/bin/zsh -c "$(source $target_dir/.zshrc)"
