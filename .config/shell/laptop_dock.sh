#!/bin/bash
# Add udev rule:
# $ cat /etc/udev/rules.d/95-monitor-hotplug.rules
# KERNEL=="card0", SUBSYSTEM=="drm", ENV{DISPLAY}=":0", RUN+="/home/dima/.config/shell/laptop_dock.sh"
# Fucking secret is that three monitors should be brought one after another,
# not simultaneously.

export XAUTHORITY=/tmp/.Xauthority
export DISPLAY=":0"

DISP_1=$(xrandr --current | grep DP2-1 | awk '{print $2}')
DISP_2=$(xrandr --current | grep DP2-2 | awk '{print $2}')

xrandr --output eDP1 --auto --output DP2-1 --off --output DP2-2 --off
if [[ "${DISP_1}" == connected ]] ; then
	xrandr --output eDP1 --auto --left-of DP2-1 --output DP2-1 --auto
fi

if [[ "${DISP_1}" == connected && "${DISP_2}" == connected ]] ; then
	xrandr --output eDP1 --auto 					\
		--left-of DP2-1 --output DP2-1 --auto			\
		--left-of DP2-2 --output DP2-2 --auto
fi

sleep 3 & feh --bg-scale /tmp/wallpaper

exit 0
