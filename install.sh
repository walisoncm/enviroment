#!/bin/bash

if ! command -v zsh &> /dev/null; then
    echo 'Zsh not found. Installing...'
    sudo pacman -S --needed --noconfirm zsh
fi

echo 'Installing oh-my-zsh'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo 'Installing the powerlevel10k theme...'
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
echo '' >> ~/.zshrc
sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

yay -S --needed --noconfirm \
    adobe-source-code-pro-fonts \
    ttf-firacode-nerd \
    ttf-hack-nerd \
    ttf-jetbrains-mono-nerd \
    ttf-meslo-nerd \
    nerd-fonts-noto-sans-mono

echo 'Installing zsh-autosuggestions'
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
echo '' >> ~/.zshrc
echo 'plugins+=(zsh-syntax-autosuggestions)' >> ~/.zshrc
echo 'source $ZSH/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh' >> ~/.zshrc

echo 'Installing zsh-syntax-highlighting'
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
echo '' >> ~/.zshrc
echo 'plugins+=(zsh-syntax-highlighting)' >> ~/.zshrc
echo 'source $ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ~/.zshrc

echo 'Updating the system...'
yay -Syu --noconfirm

echo 'Installing Zen Browser...'
yay -S --needed --noconfirm zen-browser-bin
echo '' >> ~/.zshrc
echo '# Chrome executable path' >> ~/.zshrc
echo 'export CHROME_EXECUTABLE="/usr/bin/zen-browser"' >> ~/.zshrc

echo 'Installing Ghostty...'
yay -S --needed --noconfirm ghostty tmux
echo '' >> ~/.zshrc
echo '# XDG path' >> ~/.zshrc
echo 'export XDG_CONFIG_HOME="$HOME/.config"' >> ~/.zshrc

echo 'Installing Insomnia...'
yay -S --needed --noconfirm insomnia-bin

echo 'Installing Discord...'
yay -S --needed --noconfirm discord

echo 'Installing Docker...'
yay -S --needed --noconfirm docker docker-compose
sudo usermod -aG docker $USER
sudo systemctl enable docker

echo 'Installing CUPS and Epson L3150 drivers via yay...'
yay -S --needed --noconfirm cups epson-inkjet-printer-escpr

echo 'Enabling and starting the CUPS service...'
sudo systemctl enable --now cups.service

echo 'Create Tools directory'
mkdir $HOME/Tools
echo '' >> ~/.zshrc
echo '# Tools path' >> ~/.zshrc
echo 'export TOOLS=$HOME/Tools' >> ~/.zshrc

echo 'Installing Android Studio...'
yay -S --needed --noconfirm android-studio android-tools
echo '' >> ~/.zshrc
echo '# Android SDK path' >> ~/.zshrc
echo 'export ANDROID_HOME="$TOOLS/Android/Sdk"' >> ~/.zshrc
echo 'export PATH="$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator"' >> ~/.zshrc

echo 'Installing JDK...'
yay -S --needed --noconfirm jre-openjdk jdk-openjdk
echo '' >> ~/.zshrc
echo 'JDK_DIR=$(ls -d /usr/lib/jvm/java-*/ | tail -n 1)' >> ~/.zshrc
echo 'if [ -n "$JDK_DIR" ]; then' >> ~/.zshrc
echo '  export JAVA_HOME="${JDK_DIR%/}"' >> ~/.zshrc
echo '  export PATH="$JAVA_HOME/bin:$PATH"' >> ~/.zshrc
echo 'fi' >> ~/.zshrc

echo 'Installing Flutter...'
git clone https://github.com/flutter/flutter.git $HOME/Tools/flutter
echo '' >> ~/.zshrc
echo '# Flutter SDK path' >> ~/.zshrc
echo 'export PATH="$PATH:$TOOLS/flutter/bin"' >> ~/.zshrc

echo 'Flutter dependencies'
yay -S --needed --noconfirm clang cmake ninja gradle --noconfirm

echo 'Flutter set android sdk'
flutter config --android-sdk $HOME/Tools/Android/Sdk

echo 'Flutter enable web'
flutter config --enable-web

echo "Installing NVM..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh)"
echo '' >> ~/.zshrc
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' >> ~/.zshrc
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' >> ~/.zshrc

echo "Installing Pyenv..."
sh -c "$(curl -fsSL https://pyenv.run)"
echo '' >> ~/.zshrc
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init - zsh)"' >> ~/.zshrc

echo "Installing Neovim and fzf..."
yay -S --needed --noconfirm neovim fzf
echo '' >> ~/.zshrc
echo '# Fuzy finder' >> ~/.zshrc
echo '[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh' >> ~/.zshrc

# TODO: Clone nvim config and .fzf.zsh

echo 'Changing the default shell to zsh...'
sudo chsh -s $(which zsh) "$USER"

reboot
