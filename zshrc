alias ls='exa'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

alias cd='z'

alias install='sudo pacman -S --noconfirm --needed'
alias uninstall='sudo pacman -Rns'
alias upgrade='sudo pacman -Syu --noconfirm'

# be careful with the eventID. might be different in different machines.
# run evtest to figure out the keyboard to be disabled
alias tog-kb='sudo evtest --grab /dev/input/event8'

