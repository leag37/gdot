#!/bin/bash

# General setup for shell
target_dir="$HOME"
dot_dir="$PWD/dotfiles"
curr_dir="$PWD"

# Clean old symlinks and directories and setup new ones
mkdir -p $target_dir/.config
rm $target_dir/.config/starship.toml

# Link dotfiles
ln -sf "$dot_dir/zsh/.zshrc" "$target_dir/.zshrc"
ln -sf "$dot_dir/starship/starship.toml" "$target_dir/.config/starship.toml"
ln -sf "$dot_dir/wezterm/.wezterm.lua" "$target_dir/.wezterm.lua"

# Standard installers
sudo apt update
sudo apt install clang
sudo apt install cmake
sudo apt install eza
sudo apt install fd-find
sudo apt install fzf
sudo apt install llvm
sudo apt install nvim
sudo apt install starship
sudo apt install wezterm-nightly
sudo apt install zoxide

# Install nvm without modifying shell config
PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash'

# Nerd font setup
nerd_font_name=JetBrainsMono
nerd_font_url='https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/$nerd_font_name.zip'
mkdir -p $HOME/.fonts
cd $HOME/.fonts
curl -OL $nerd_font_url
fc-cache -fv
cd $curr_dir

# Change shell to zsh
chsh -s $(which zsh)

# Source zsh in case we are rerunning the setup
exec /bin/zsh
/bin/zsh -c "$(source $target_dir/.zshrc)"
