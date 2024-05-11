#!/bin/bash

echo "FireStreaker2's dotfiles"

ISYAY=/sbin/yay
if [ -f "$ISYAY" ]; then
  echo -e "yay was located, moving on.\n"
  yay
else
  echo -e "yay was not located, please install yay. Exiting.\n"
  exit
fi

read -n1 -rep "Would you like to install required packages? (y,n)" INST
if [[ $INST == "Y" || $INST == "y" ]]; then
  yay -S --noconfirm hyprland kitty waybar \
    wofi cava fish hypridle hyprlock wlogout thunar \
    ttf-jetbrains-mono-nerd noto-fonts-emoji \
    polkit-gnome python-requests starship \
    swappy grim slurp pamixer brightnessctl gvfs \
    bluez bluez-utils neofetch neovim swaync \
    xdg-desktop-portal-hyprland sddm blueman \
    nm-connection-editor wl-clipboard swaybg \
    swayosd-git

  yay -R --noconfirm xdg-desktop-portal-gnome xdg-desktop-portal-gtk xdg-desktop-portal-kde

  echo "Packages have been installed!"
fi

read -n1 -rep "Would you like to copy config files? (y,n)" CFG
if [[ $CFG == "Y" || $CFG == "y" ]]; then
  cp -R cava ~/.config/
  cp -R fish ~/.config/
  cp -R hypr ~/.config/
  cp -R kitty ~/.config/
  cp -R neofetch ~/.config/
  cp -R nvim ~/.config/
  cp -R swaync ~/.config/
  cp -R waybar ~/.config/
  cp -R swaylock ~/.config/
  cp -R wofi ~/.config/

  cp starship.toml ~/.config/

  cp -R Pictures ~/

  chmod +x ~/.config/hypr/xdg-portal-hyprland
  chmod +x ~/.config/waybar/mediaplayer.py
fi

read -n1 -rep "Would you like to install the Gura SDDM theme? (y,n)" SDDM
if [[ $SDDM == "Y" || $SDDM == "y" ]]; then
  git clone https://github.com/FireStreaker2/Gura-SDDM.git ~/Gura-SDDM
  mv ~/Gura-SDDM /usr/share/sddm/themes/
  sed -i "s/^Current=.*$/Current=gura-sddm/" /etc/sddm.conf

  echo -e "Succesfully set the SDDM theme!\n"
fi

read -n1 -rep "Would you like to change your default shell to fish? (y,n)" SHL
if [[ $SHL == "Y" || $SHL == "y" ]]; then
  chsh --shell=/usr/bin/fish $USER
  echo -e "Succesfully changed shell! Note that you may have to reboot in order for changes to apply.\n"
fi

echo -e "Installation has succesfully finished.\n"
read -n1 -rep "Would you like to start Hyprland now? (y,n)" HYP
if [[ $HYP == "Y" || $HYP == "y" ]]; then
  exec Hyprland
else
  exit
fi
