#!/bin/sh
xsetroot -name "Wait..."
while true; do
	BAT0=`find /sys/devices -name capacity -exec cat {} \;`
	[ -z $BAT0 ] && BATTERY="INF" || BATTERY="$BAT0%"
	DATETIME=`date '+%d.%m %H:%M'`
	xsetroot -name "BAT=$BATTERY | $DATETIME"
	sleep 30
done
