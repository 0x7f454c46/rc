#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

MACHINE_NAME=$(uname -n)
NOTEBOOK_NAME=jimi

# machine differences

if [[ "${MACHINE_NAME}" == "${NOTEBOOK_NAME}" ]]
XRESOURSES_XTERM_FONT="xterm*faceName: terminus:pixelsize=18"
else
XRESOURSES_XTERM_FONT="xterm*faceName: terminus:pixelsize=20"
fi

# wallpapers settings

WALLPAPER_PATH="pic/wall/"
# or set explicitly with WALLPAPER="1.jpg"
WALLPAPER="$(ls "$WALLPAPER_PATH" -1 | sort --random-sort | head -1)"
# Xresources theme from ~/.config/Xresources
XTHEME="best/black_purple"

# do not want it @ home
mv .Xauthority /tmp/
export XAUTHORITY=/tmp/.Xauthority

# merge xresources in
xrdb -merge <<EOF
Xft.dpi: 96
Xft.hinting: true
Xft.hintstyle: hintslight
Xft.antialias: true
Xft.rgba: rgb

dzen2.font: -*-terminus-*-*-*-*-*-*-*-*-*-*-*-*
dzen2.background: black
dzen2.foreground: #858585

${XRESOURSES_XTERM_FONT}
xterm*saveLines: 2048
xterm*scrollBar: off
xterm*rightScrollBar: off
EOF

# start some awful programs dbus/systemd sessions
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

[[ -f ~/.config/Xresources/${XTHEME} ]] &&
	xrdb -merge ~/.config/Xresources/${XTHEME} &

[[ -f "${WALLPAPER_PATH}${WALLPAPER}" ]] &&
	hsetroot -fill "${WALLPAPER_PATH}${WALLPAPER}"

DEFAULT_SESSION=i3
case $1 in
i3)
	exec i3
	;;
*)
	exec "$DEFAULT_SESSION"
	;;
esac
