#!/bin/bash

# General setup for shell
target_dir="$HOME"
dot_dir="$PWD/dotfiles"

# Clean old symlinks and directories

# Link dotfiles
ln -sf "$dot_dir/zsh/.zshrc" "$target_dir/.zshrc"

# Install wezterm

# Source zsh in case we are rerunning the setup
exec /bin/zsh
/bin/zsh -c "$(source $target_dir/.zshrc)"
