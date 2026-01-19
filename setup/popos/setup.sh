#!/bin/bash

# General setup for shell
target_dir="$HOME"
dot_dir="$PWD/dotfiles"
curr_dir="$PWD"

# Clean old symlinks and directories and setup new ones
mkdir -p $target_dir/.config
rm $target_dir/.zshrc
rm $target_dir/.config/nvim
rm $target_dir/.config/starship.toml
rm $target_dir/.wezterm.lua

# Link dotfiles
ln -sf "$dot_dir/zsh/.zshrc" "$target_dir/.zshrc"
ln -sf "$dot_dir/starship/starship.toml" "$target_dir/.config/starship.toml"
ln -sf "$dot_dir/wezterm/.wezterm.lua" "$target_dir/.wezterm.lua"
ln -sf "$dot_dir/nvim" "$target_dir/.config/nvim"

# Standard installers
sudo apt update
sudo apt install build-essential
sudo apt install clang
sudo apt install cmake
sudo apt install eza
sudo apt install fd-find
sudo apt install fzf
sudo apt install lazygit
sudo apt install libreadline-dev
sudo apt install llvm
sudo apt install nvim
sudo apt install python3.12-venv
sudo apt install rebar3
sudo apt install ripgrep
sudo apt install starship
sudo apt install unzip
sudo apt install wezterm-nightly
sudo apt install wl-clipboard
sudo apt install zoxide

# Snap installers


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

# Install LazyGit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar -xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/
rm -rf lazygit
rm lazygit.tar.gz

# DotNet
sudo apt install -y dotnet-sdk-10.0
sudo apt install -y aspnetcore-runtime-10.0

# Go language
sudo rm -rf /usr/local/go
curl -Lo go.1.25.6.linux-amd64.tar.gz "https://go.dev/dl/go1.25.6.linux-amd64.tar.gz"
sudo tar -C /usr/local -xzf go.1.25.6.linux-amd64.tar.gz
rm go.1.25.6.linux-amd64.tar.gz
echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.profile

# Haskell
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

# Lua
luav=lua-5.5.0
curl -Lo $luav.tar.gz "https://www.lua.org/ftp/$luav.tar.gz"
tar xf $luav.tar.gz
cd $luav
make all test
sudo make install
cd ..
rm $luav.tar.gz
rm -rf $luav

lua_rocks=luarocks-3.13.0
curl -Lo $lua_rocks.tar.gz "https://luarocks.github.io/luarocks/releases/$lua_rocks.tar.gz"
tar xf $lua_rocks.tar.gz
cd $lua_rocks
./configure --with-lua-include=/usr/local/include
make
sudo make install
cd ..
rm $lua_rocks.tar.gz
rm -rf $lua_rocks

# Change shell to zsh
chsh -s $(which zsh)

# Source zsh in case we are rerunning the setup
exec /bin/zsh
/bin/zsh -c "$(source $target_dir/.zshrc)"
