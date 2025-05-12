# enviroment

## Updating the system
```sh
sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm git base-devel
```

## Installing yay
```sh
git clone https://aur.archlinux.org/yay.git
```
```sh
cd yay
```
```sh
makepkg -si --noconfirm
```
```sh
cd ..
```
```sh
rm -rf yay
```

## Install enviroment
```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/walisoncm/enviroment/refs/heads/main/install.sh)"
```

## Finishing Flutter settings

Open android-studio and access `More Actions > SDK Manager > SDK Tools` and check the option `Android SDK Command-line Tools (latest)` confirm and finish.

```sh
mv $HOME/Android $TOOLS
```

Open android-studio again and define install directory to: "~/Tools/Android/Sdk" and next and close.

```sh
flutter doctor --android-licenses
```

```sh
flutter doctor
```

## Uninstall enviroment
```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/walisoncm/enviroment/refs/heads/main/uninstall.sh)"
```

## Uninstall yay
```sh
sudo pacman -Rns yay
```
