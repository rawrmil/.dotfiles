#!/bin/bash

pkill dwm-loop
pkill app_process
termux-x11 :0 &
proot-distro login debian --shared-tmp --isolated -- bash -c "sudo bash ~/.xinitrc" &
