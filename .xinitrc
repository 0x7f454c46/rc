#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

#if [ -d /etc/X11/xinit/xinitrc.d ]; then
#  for f in /etc/X11/xinit/xinitrc.d/*; do
#    [ -x "$f" ] && . "$f"
#  done
#  unset f
#fi

WALLPAPER_PATH="pic/wall/"
# WALLPAPER="1.jpg"
WALLPAPER="$(ls "$WALLPAPER_PATH" -1 | sort --random-sort | head -1)"
# Xresources theme from ~/.config/Xresources
XTHEME="best/black_purple"

mv .Xauthority /tmp/
export XAUTHORITY=/tmp/.Xauthority

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources &&
	xrdb -merge ~/.config/Xresources/${XTHEME} &
[[ -f "${WALLPAPER_PATH}${WALLPAPER}" ]] &&
	hsetroot -fill "${WALLPAPER_PATH}${WALLPAPER}"
unset WALLPAPER_PATH
unset WALLPAPER

DEFAULT_SESSION=i3
case $1 in
wmii)
	exec wmii
	;;
i3)
	exec i3
	;;
awesome)
	exec awesome
	;;
*)
	exec "$DEFAULT_SESSION"
	;;
esac
