#!/bin/sh

pgrep -x dmenu && exit

mountable=$(lsblk -lp | grep "part $" | awk '{print $1, "(" $4 ")"}')
[[ "$mountable" = "" ]] && exit 1
chosen=$(echo "$mountable" | dmenu -i -p "Mount which drive?" | awk '{print $1}')
[[ "$chosen" == "" ]] && exit 1
sudo mount "$chosen" && exit 0
dirs=$(find /mnt /media /mount /home -type d -maxdepth 3 2>/dev/null)
mounttpoint=$(echo "$dirs" | dmenu -i -p "Type in mount point.")
[[ "$mounttpoint" = "" ]] && exit 1
if [[ ! -d "$mounttpoint" ]]; then
    mkdiryn=$(echo -e "No\nYes" | dmenu -i -p "$mounttpoint does not exist. Create it?")
    [[ "$mkdiryn" = Yes ]] && sudo mkdir -p "$mounttpoint"
fi
sudo mount $chosen $mounttpoint
