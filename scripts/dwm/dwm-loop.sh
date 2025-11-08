#!/bin/sh

set -x

source ~/.dotfiles/scripts/utils/hascmd.sh

cleanup() {
    pkill -P $$
    wait
    exit 0
}
trap cleanup INT TERM EXIT

while true; do
	[ hascmd hsetroot ] && hsetroot -solid black
	[ hascmd setxkbmap ] && setxkbmap -layout us,ru -option grp:alt_shift_toggle
	[ hascmd picom ] && picom -b --config ~/dots/dwm/picom.conf
	[ hascmd flameshot ] && flameshot &
	[ hascmd xrdb ] && xrdb -merge $HOME/.Xresources
	~/.dotfiles/scripts/dwm/dwm-bar.sh &
	dwm
	sleep 1
done
