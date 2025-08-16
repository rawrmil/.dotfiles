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
	hsetroot -solid black
	setxkbmap -layout us,ru -option grp:alt_shift_toggle
	picom -b --config ~/dots/dwm/picom.conf
	flameshot &
	#pipewire &
	pipewire-pulse &
	wireplumber &
	xrdb -merge $HOME/.Xresources
	~/.dotfiles/scripts/dwm/dwm-bar.sh &
	dwm
	sleep 1
done
