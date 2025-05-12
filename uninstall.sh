#!/bin/bash

echo "Uninstalling Zen Browser..."
sudo pacman -Rns --noconfirm zen-browser-bin

echo "Uninstalling Ghostty..."
sudo pacman -Rns --noconfirm ghostty

echo "Uninstalling Docker and Docker Desktop..."
sudo pacman -Rns --noconfirm docker docker-desktop
sudo gpasswd -d $USER docker # Removing user from the docker group

echo "Uninstalling CUPS and Epson L3150 drivers..."
sudo pacman -Rns --noconfirm cups epson-inkjet-printer-escpr

echo "Disabling and stopping the CUPS service..."
sudo systemctl disable --now cups.service

echo "Uninstalling Android Studio and tools..."
sudo pacman -Rns --noconfirm android-studio android-tools

echo "Uninstalling JDK..."
sudo pacman -Rns --noconfirm jre-openjdk jdk-openjdk

echo "Removing flutter..."
rm -rf $HOME/Tools/flutter

echo "Uninstalling Flutter dependencies..."
sudo pacman -Rns --noconfirm clang cmake ninja gradle

echo "Removing Tools directory..."
rm -rf $HOME/Tools

echo "Uninstalling NVM..."
sudo pacman -Rns --noconfirm nvm

echo "Uninstalling Pyenv..."
rm -rf $HOME/.pyenv

echo "Uninstalling Neovim and fzf..."
sudo pacman -Rns --noconfirm neovim fzf

echo "Removing zsh-syntax-highlighting..."
rm -rf "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"

echo "Removing zsh-autosuggestions..."
rm -rf "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

echo "Removing the powerlevel10k theme..."
rm -rf "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

echo "Removing oh-my-zsh..."
rm -rf ~/.oh-my-zsh

echo "Uninstalling Powerlevel10k suggested fonts..."
sudo pacman -Rns --noconfirm \
    adobe-source-code-pro-fonts \
    nerd-fonts-fira-code \
    nerd-fonts-hack \
    nerd-fonts-jetbrains-mono \
    nerd-fonts-meslo-lg \
    nerd-fonts-noto-sans-mono

echo "Restoring default shell to bash..."
sudo chsh -s $(which bash) "$USER"

echo "Uninstalling Zsh..."
sudo pacman -Rns --noconfirm zsh

echo "Uninstallation complete.  You may need to restart your terminal or the system."
