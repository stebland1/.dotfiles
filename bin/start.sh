#!/usr/bin/env bash

# Check if git is installed
if ! command -v git &>/dev/null; then
	echo "Git is not installed. Please install Git and run the script again."
	exit 1
fi

install_brew_macos() {
	if ! command -v brew &>/dev/null; then
		echo "Homebrew is not installed. Installing Homebrew..."
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi
}

install_brew() {
	install_brew_macos

	echo "Installing dependencies with Homebrew..."
	brew update
	brew install \
		neovim \
		yabai \
		skhd \
		tmux \
		zsh \
		jq \
		ripgrep \
		fzf \
		bat \
		wget \
		lazygit \
		stow \
		kitty
}

install_brew

# Now proceed with setting up your dotfiles using Stow
echo "Setting up dotfiles using Stow..."

# Assuming your dotfiles are in a directory called 'dotfiles'
cd ~/dotfiles || exit

stow . -v "$dir" # This creates the symlinks for each directory

# Example to start a terminal like Kitty (or any app)
echo "Starting Kitty (or your terminal of choice)..."
kitty &
