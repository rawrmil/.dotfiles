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
	xrdb -merge $HOME/.Xresources
	pipewire &
	pipewire-pulse &
	pipwire-media-session &
	~/.dotfiles/scripts/dwm/dwm-bar.sh &
	dwm
	sleep 1
done
