#!/bin/bash

# Funkcja do sprawdzenia, czy narzędzie jest zainstalowane
check_install() {
  if ! command -v $1 &> /dev/null
  then
    echo "$1 nie jest zainstalowane. Instalowanie..."
    sudo apt update && sudo apt install -y $1
  else
    echo "$1 jest już zainstalowane."
  fi
}

# Instalacja niezbędnych narzędzi
check_install "zsh"
check_install "kitty"

# Instalacja paczek (możesz dodać własne paczki, np. z listy paczek manualnych)
echo "Instalowanie paczek..."
# Przykład instalacji paczek (zależy od dystrybucji)
sudo apt install -y \
  zsh \
  oh-my-zsh \
  kitty \
  plasma-desktop \
  kde-config-gtk-style

# Zmieniamy powłokę na ZSH
echo "Zmiana powłoki na ZSH..."
chsh -s $(which zsh)

# Tworzymy symlinki z dotfiles
echo "Tworzenie symlinków z dotfiles..."
ln -sf $PWD/zsh/.zshrc ~/
ln -sf $PWD/config/kitty ~/ .config/
ln -sf $PWD/config/kdeglobals ~/.config/
ln -sf $PWD/config/kwinrc ~/.config/
ln -sf $PWD/config/plasmarc ~/.config/

# Dodatkowe komendy, np. do uruchomienia plasmy
echo "Ustawienie domyślnej aplikacji na KDE..."
kwriteconfig5 --file kwinrc SwitchToNextTabOnCtrlTab true

echo "Instalacja zakończona! Uruchom ponownie komputer."
