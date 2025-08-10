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
	#~/.dwm-start.sh
	~/.dotfiles/scripts/dwm/dwm-bar.sh &
	sleep 1
	xrandr --output eDP1 --mode 1920x1200
	dwm
	sleep 1
done
