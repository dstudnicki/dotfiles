#!/bin/bash

set -e

echo "===> [1/5] Installing packages..."
sudo apt update
sudo apt install -y \
  zsh kitty git curl wget \
  kde-plasma-desktop \
  plasma-discover \
  sddm \
  fonts-firacode

echo "===> [2/5] Copying KDE configuration files to ~/.config..."
mkdir -p ~/.config
cp -rv config/* ~/.config/

echo "===> [3/5] Copying Plasma themes, look-and-feel and widgets to ~/.local/share/plasma..."
mkdir -p ~/.local/share/plasma
cp -rv local/share/plasma/* ~/.local/share/plasma/

echo "===> [4/5] Installing ZSH configuration and oh-my-zsh..."
cp -v zshrc ~/.zshrc
cp -rv oh-my-zsh ~/.oh-my-zsh

echo "===> [5/5] Copying Kitty terminal config..."
mkdir -p ~/.config/kitty
cp -rv kitty/* ~/.config/kitty/

echo "===> Setting ZSH as the default shell..."
chsh -s $(which zsh)

echo "===> Restarting KDE Plasma shell..."
kquitapp5 plasmashell || true
kstart5 plasmashell &

echo "✅ Dotfiles installation complete!"
