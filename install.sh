#!/bin/bash

if ! command -v zsh &> /dev/null; then
    echo "Zsh not found. Installing..."
    sudo pacman -S --needed --noconfirm zsh
fi

echo "Changing the default shell to zsh..."
chsh -s $(which zsh) "$USER"
echo "The default shell has been changed. Opening a new terminal window."

echo "Updating the system..."
yay -Syu --noconfirm

echo "Installing Zen Browser"
yay -S --needed --noconfirm zen-browser-bin

echo "Installing CUPS and Epson L3150 drivers via yay..."
yay -S --needed --noconfirm cups epson-inkjet-printer-escpr

echo "Enabling and starting the CUPS service..."
sudo systemctl enable --now cups.service

echo "Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing zsh-syntax-highlighting"
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"

echo "Installing zsh-autosuggestions"
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

echo "Installing the powerlevel10k theme..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

echo "Installing Powerlevel10k suggested fonts..."
yay -S --needed --noconfirm \
    adobe-source-code-pro-fonts \
    nerd-fonts-fira-code \
    nerd-fonts-hack \
    nerd-fonts-jetbrains-mono \
    nerd-fonts-meslo-lg \
    nerd-fonts-noto-sans-mono

echo "Activates the powerlevel10k theme in the zsh configuration file..."
echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> ~/.zshrc

echo "Activates the zsh-syntax-highlighting plugin in the zsh configuration file..."
echo 'plugins+=(zsh-syntax-autosuggestions)' >> ~/.zshrc
echo 'source $ZSH/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh' >> ~/.zshrc

echo "Activates the zsh-syntax-highlighting plugin in the zsh configuration file..."
echo 'plugins+=(zsh-syntax-highlighting)' >> ~/.zshrc
echo 'source $ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ~/.zshrc

echo "Installing Neovim and fzf..."
yay -S --needed --noconfirm neovim fzf
echo '[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh' >> ~/.zshrc
