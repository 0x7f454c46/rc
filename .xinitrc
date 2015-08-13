#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

USERRESOURCES=$HOME/.Xresources
USERMODMAP=$HOME/.Xmodmap
SYSRESOURCES=/etc/X11/xinit/.Xresources
SYSMODMAP=/etc/X11/xinit/.Xmodmap

WALLPAPER_PATH="pic/wall/"
# WALLPAPER="1.jpg"
WALLPAPER="$(ls "$WALLPAPER_PATH" -1 | sort --random-sort | head -1)"
# Xresources theme from ~/.config/Xresources
XTHEME="best/black_purple"

mv .Xauthority /tmp/
export XAUTHORITY=/tmp/.Xauthority

# merge in defaults and keymaps

[[ -f $SYSRESOURCES ]] &&
	xrdb -merge $SYSRESOURCES

[[ -f $SYSMODMAP ]] &&
	xmodmap $SYSMODMAP

[[ -f "$USERRESOURCES" ]] &&
	xrdb -merge "$USERRESOURCES"

[[ -f "$USERMODMAP" ]] &&
	xmodmap "$USERMODMAP"

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources &&
	xrdb -merge ~/.config/Xresources/${XTHEME} &
[[ -f "${WALLPAPER_PATH}${WALLPAPER}" ]] &&
	hsetroot -fill "${WALLPAPER_PATH}${WALLPAPER}"
unset WALLPAPER_PATH
unset WALLPAPER

DEFAULT_SESSION=i3
case $1 in
i3)
	exec i3
	;;
*)
	exec "$DEFAULT_SESSION"
	;;
esac
