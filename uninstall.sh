#!/bin/bash

echo "Uninstalling Zen Browser..."
sudo pacman -Rns zen-browser-bin --noconfirm
echo "Zen Browser has been uninstalled."

echo "Uninstalling Neovim and fzf..."
sudo pacman -Rns neovim fzf --noconfirm
sed -i '/\[ -f \~\/\.fzf\.zsh \] \&\& source \~\/\.fzf\.zsh/d' ~/.zshrc
echo "Neovim and fzf have been uninstalled."

echo "Uninstalling pyenv..."
sudo pacman -Rns python-pyenv --noconfirm
echo "pyenv has been uninstalled."
rm -rf ~/.pyenv
sed -i '/export PYENV_ROOT=.*$/d' ~/.zshrc
sed -i '/command -v pyenv >\/dev\/null \|\| export PATH="\$PYENV_ROOT\/bin:\$PATH"$/d' ~/.zshrc
sed -i '/eval "\$\(pyenv init - zsh\)"/d' ~/.zshrc
echo "pyenv related files and configurations removed."

echo "Uninstalling nvm..."
rm -rf ~/.nvm
echo "nvm has been uninstalled."
sed -i '/export NVM_DIR=.*$/d' ~/.zshrc
sed -i '/\[ -s "\$NVM_DIR\/nvm\.sh" \] \&\& \. "\$NVM_DIR\/nvm\.sh" # This loads nvm$/d' ~/.zshrc
sed -i '/\[ -s "\$NVM_DIR\/bash_completion" \] \&\& \. "\$NVM_DIR\/bash_completion" # This loads nvm bash_completion$/d' ~/.zshrc
sed -i '/source \/usr\/share\/nvm\/init\.sh$/d' ~/.zshrc
echo "nvm related files and configurations removed."

echo "Disabling and stopping the CUPS service..."
sudo systemctl disable --now cups.service
echo "CUPS service has been disabled and stopped."

echo "Uninstalling CUPS and Epson drivers..."
sudo pacman -Rns cups epson-inkjet-printer-escpr --noconfirm
echo "CUPS and Epson drivers have been uninstalled."

echo "Removing the Oh-My-Zsh directory..."
rm -rf ~/.oh-my-zsh
echo "Oh-My-Zsh directory removed."

echo "Uninstalling fonts suggested by Powerlevel10k..."
sudo pacman -Rns \
  adobe-source-code-pro-fonts \
  nerd-fonts-fira-code \
  nerd-fonts-hack \
  nerd-fonts-jetbrains-mono \
  nerd-fonts-meslo-lg \
  nerd-fonts-noto-sans-mono --noconfirm
echo "Fonts suggested by Powerlevel10k have been uninstalled."

echo "Removing lines added to ~/.zshrc..."
sed -i '/ZSH_THEME="powerlevel10k\/powerlevel10k"/d' ~/.zshrc
sed -i '/plugins+=(zsh-syntax-autosuggestions)/d' ~/.zshrc
sed -i '/source \$ZSH\/custom\/plugins\/zsh-autosuggestions\/zsh-autosuggestions.plugin.zsh/d' ~/.zshrc
sed -i '/plugins+=(zsh-syntax-highlighting)/d' ~/.zshrc
sed -i '/source \$ZSH\/custom\/plugins\/zsh-syntax-highlighting\/zsh-syntax-highlighting.zsh/d' ~/.zshrc
echo "Relevant lines removed from ~/.zshrc. You might want to review the file for other modifications."

if [[ "$SHELL" == *"/zsh" ]]; then
  echo "Your current shell is Zsh. Attempting to switch to Bash..."
  sudo chsh -s $(which bash) "$USER"
  echo "The default shell has been changed to Bash. You might need to restart your terminal or session."
else
  echo "Your current shell is not Zsh, skipping default shell change."
fi

echo "Uninstalling Zsh..."
sudo pacman -Rns zsh --noconfirm
echo "Zsh has been uninstalled."
