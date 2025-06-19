#!/usr/bin/env bash

# This bash script is meant to be fetched from https://github.com/Sodium727/Datcty, packed with everything included in the repo
# It automates the post-installation of Arch Linux

# Update the system and install required packages using pacman
# sudo pacman -Sy --needed archlinux-keyring 
# sudo pacman-key --init
# sudo pacman-key --populate archlinux

# Packages (general)
sudo pacman -Sy --noconfirm --needed git base-devel less qbittorrent ripgrep neovim imv bat eza zoxide fcitx5 fcitx5-unikey fcitx5-config-qt mpv zsh firefox flatpak ttf-jetbrains-mono-nerd 7zip alacritty noto-fonts-cjk thunar

# Packages (Sway)
sudo pacman -S --noconfirm --needed sway swaybg swaylock grim slurp mako cliphist swayidle

# Packages (Hyprland)
# sudo pacman -S --noconfirm --needed hyprlock hyprland hyprpaper hyprpolkitagent hyprsunset hyprpicker waybar

# Install yay
git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si

# AUR Packages
yay -S --noconfirm --needed ventoy-bin

# AUR Packages (Hyprland)
# yay -S --noconfirm --needed hyprshot wlogout waypaper

# AUR Packages (Sway)
yay -S --noconfirm --needed tofi

# Install Packer plugin manager for Neovim
# git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# pull the nvim/ from configs/ to ~/.config and run :PackerSync in neovim

# JaKooLit's hyprland 
# git clone https://github.com/JaKooLit/Arch-Hyprland.git ~/Arch-Hyprland
# cd ~/Arch-Hyprland
# chmod +x install.sh
# ./install.sh

# end-4's illogical impulse hyprland
# bash <(curl -s "https://end-4.github.io/dots-hyprland-wiki/setup.sh")

# Zsh Setup
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" 
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
 
cat <<EOF
Remember to copy everything from configs/zshrc to ~/.zshrc
EOF

# Stuffs
cat <<EOF
Add the stuff from configs/ (except rofi-beats and zshrc) to ~/.config and it should be ok.

Pull the sodium-sddm/ to /usr/share/sddm/themes/ too, then,
Write this into /etc/sddm.conf:
[Theme]
  Current=sodium-sddm

Copy the aliases from configs/zshrc to ~/.zshrc

CHECK /etc/pacman.conf, AND ADD THESE REPOS:

[core-testing]
Include = /etc/pacman.d/mirrorlist
[core]
Include = /etc/pacman.d/mirrorlist
[extra-testing]
Include = /etc/pacman.d/mirrorlist
[extra]
Include = /etc/pacman.d/mirrorlist
[multilib-testing]
Include = /etc/pacman.d/mirrorlist
[multilib]
Include = /etc/pacman.d/mirrorlist
[chaotic-aur]
SigLevel = Never
Server = https://cdn-mirror.chaotic.cx/chaotic-aur/$arch
EOF

# Wine (and other driver stuffs)
# sudo pacman -Sy --needed wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama ncurses lib32-ncurses ocl-icd lib32-ocl-icd libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader wine-staging winetricks vulkan-headers lib32-mesa lib32-vulkan-icd-loader mesa vulkan-intel gnutls lib32-gnutls vulkan-intel lib32-vulkan-intel wine-mono

# winetricks d3dcompiler_47 d3d9 d3d11 dxvk vulkan
