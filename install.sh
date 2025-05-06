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

echo "===> [4/5] Installing ZSH configuration and oh-my-zsh with powerlevel10k theme..."
cp -v zshrc/.zshrc ~/.zshrc
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
cp powerlevel10k/.p10k.zsh ~/.p10k.zsh

echo "===> [5/5] Copying Kitty terminal config..."
mkdir -p ~/.config/kitty
cp -rv config/kitty/* ~/.config/kitty/

echo "===> Setting ZSH as the default shell..."
chsh -s $(which zsh)

echo "===> Restarting KDE Plasma shell..."
kquitapp5 plasmashell || true
kstart5 plasmashell &

echo "✅ Dotfiles installation complete!"
