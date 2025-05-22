#!/usr/bin/env bash
# This bash script is meant to be fetched from https://github.com/Sodium727/Datcty, packed with everything included in the repo
# It automates the post-installation of Arch Linux

# Update the system and install required packages using pacman
# sudo pacman -Sy --needed archlinux-keyring 
# sudo pacman-key --init
# sudo pacman-key --populate archlinux

# Essentials
sudo pacman -Sy --noconfirm --needed git base-devel clang xclip dos2unix fastfetch qbittorrent gdb ripgrep neovim imv dosfstools ntfs-3g bat eza zoxide fcitx5 fcitx5-unikey fcitx5-qt fcitx5-gtk fcitx5-configtool mpv zsh kitty sddm firefox cliphist

# For using Wine (and other stuffs)
# sudo pacman -S --needed wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama ncurses lib32-ncurses ocl-icd lib32-ocl-icd libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader wine-staging winetricks vulkan-headers lib32-mesa lib32-vulkan-icd-loader mesa vulkan-intel gnutls lib32-gnutls vulkan-intel lib32-vulkan-intel wine-mono noto-fonts-cjk noto-fonts-emoji noto-fonts-extra noto-fonts

# winetricks d3dcompiler_47 d3d9 d3d11 dxvk vulkan

# Install yay
git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si

# Install font and other stuffs
yay -S --noconfirm --needed ttf-jetbrains-mono-nerd flashplayer-standalone

# Install Packer plugin manager for Neovim
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Then install neovim, pull the nvim/ from configs/ to ~/.config and run :PackerSync in neovim

# Setup Hyprland + Preconfigured setup (ABANDONED.)
# git clone https://github.com/JaKooLit/Arch-Hyprland.git ~/Arch-Hyprland
# cd ~/Arch-Hyprland
# chmod +x install.sh
# ./install.sh

# end-4's illogical impulse (Won't use it unless feeling fancy)
# bash <(curl -s "https://end-4.github.io/dots-hyprland-wiki/setup.sh")

# Zsh Setup
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" 
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k


# Hyprland setup
yay -S --needed hyprcursor hyprgraphics hyprland hyprland-qt-support-git hyprland-qt-support-git-debug hyprland-qtutils hyprlang-git hyprlang-git-debug hyprpaper hyprpolkitagent hyprshot hyprsunset hyprutils-git hyprutils-git-debug hyprwayland-scanner-git hyprwayland-scanner-git-debug --noconfirm

# Extras
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
