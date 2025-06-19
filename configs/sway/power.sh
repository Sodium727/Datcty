#!/usr/bin/env bash

printf "Lock\nLogout\nSuspend\nReboot\nPoweroff" | \
  tofi --prompt-text="Power Menu" \
       --font /usr/share/fonts/TTF/JetBrainsMonoNerdFont-Regular.ttf \
       --num-results 5 \
       --hint-font false \
       --ascii-input true \
       --width 999 \
       --height 333 | \
  while read -r choice; do
    case "$choice" in
      "Lock")     swaylock -i /home/dat/Pictures/Wallpapers/Northern\ Lights3.png ;;
      "Logout")   swaymsg exit ;;
      "Suspend")  systemctl suspend ;;
      "Reboot")   systemctl reboot ;;
      "Poweroff") systemctl poweroff ;;
    esac
  done

