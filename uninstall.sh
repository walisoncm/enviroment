#!/bin/bash

echo "Desinstalando Zen Browser..."
sudo pacman -Rns zen-browser-bin
echo "Zen Browser foi desinstalado."

echo "Desinstalando CUPS e drivers Epson..."
sudo pacman -Rns cups epson-inkjet-printer-escpr
echo "CUPS e drivers Epson foram desinstalados."

echo "Desabilitando e parando o serviço CUPS..."
sudo systemctl disable --now cups.service
echo "Serviço CUPS foi desabilitado e parado."

echo "Removendo o diretório do Oh-My-Zsh..."
rm -rf ~/.oh-my-zsh
echo "Diretório do Oh-My-Zsh removido."

echo "Desinstalando as fontes sugeridas pelo Powerlevel10k..."
sudo pacman -Rns \
  adobe-source-code-pro-fonts \
  nerd-fonts-fira-code \
  nerd-fonts-hack \
  nerd-fonts-jetbrains-mono \
  nerd-fonts-meslo-lg \
  nerd-fonts-noto-sans-mono
echo "Fontes sugeridas pelo Powerlevel10k foram desinstaladas."

echo "Removendo as linhas adicionadas ao ~/.zshrc..."
sed -i '/ZSH_THEME="powerlevel10k\/powerlevel10k"/d' ~/.zshrc
sed -i '/plugins+=(zsh-syntax-autosuggestions)/d' ~/.zshrc
sed -i '/source \$ZSH\/custom\/plugins\/zsh-autosuggestions\/zsh-autosuggestions.plugin.zsh/d' ~/.zshrc
sed -i '/plugins+=(zsh-syntax-highlighting)/d' ~/.zshrc
sed -i '/source \$ZSH\/custom\/plugins\/zsh-syntax-highlighting\/zsh-syntax-highlighting.zsh/d' ~/.zshrc
sed -i '/\[ -f \~\/\.fzf\.zsh \] \&\& source \~\/\.fzf\.zsh/d' ~/.zshrc
echo "Linhas relevantes removidas do ~/.zshrc. Você pode querer revisar o arquivo para outras modificações."

echo "Desinstalando Neovim e fzf..."
sudo pacman -Rns neovim fzf
echo "Neovim e fzf foram desinstalados."

if [[ "$SHELL" == *"/zsh" ]]; then
  echo "Seu shell atual é Zsh. Tentando mudar para Bash..."
  sudo chsh -s $(which bash) "$USER"
  echo "O shell padrão foi alterado para Bash. Você pode precisar reiniciar o terminal ou a sessão."
else
  echo "Seu shell atual não é Zsh, pulando a alteração do shell padrão."
fi

echo "Desinstalando o Zsh..."
sudo pacman -Rns zsh
rm -rf ~/.oh-my-zsh
echo "Zsh foi desinstalado."
