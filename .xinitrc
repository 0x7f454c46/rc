#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

# to use script commands here, i.e: set_wallpaper
[[ -f ~/.config/shell/include ]] &&
	source ~/.config/shell/include

WALLPAPER_PATH="pic/wall"
# or set explicitly with WALLPAPER="1.jpg"
WALLPAPER="$(ls "$WALLPAPER_PATH" -1 | sort --random-sort | head -1)"

SYS_RESOURCES=/etc/X11/xinit/.Xresources
SYS_MODMAP=/etc/X11/xinit/.Xmodmap
USER_RESOURCES=~/.Xresources
USER_NODE_RESOURCES=${NODE_PATH}/.Xresources
USER_NODE_THEME=${NODE_PATH}/.Xtheme

I3_CONFIG=~/.config/i3/config
I3_NODE_CONFIG=${NODE_PATH}/.config/i3/config

DEFAULT_SESSION=i3

# do not want it @ home
mv .Xauthority /tmp/
export XAUTHORITY=/tmp/.Xauthority

# start some awful programs dbus/systemd sessions
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# xrdb merges
[[ -f "${SYS_RESOURCES}" ]] &&
	xrdb -merge "${SYS_RESOURCES}"
[[ -f "${SYS_MODMAP}" ]] &&
	xmodmap "${SYS_MODMAP}"
[[ -f "${USER_RESOURCES}" ]] &&
	xrdb -merge "${USER_RESOURCES}"
[[ -f "${USER_NODE_RESOURCES}" ]] &&
	xrdb -merge "${USER_NODE_RESOURCES}"
[[ -f "${USER_NODE_THEME}" ]] &&
	xrdb -merge "${USER_NODE_THEME}"

[[ -f "${WALLPAPER_PATH}/${WALLPAPER}" ]] &&
	set_wallpaper "${WALLPAPER_PATH}/${WALLPAPER}"

case $1 in
i3)
	# Note, that this way re-read config in i3 will not work.
	# FIXME: add this to generic i3 config (read docs).
	I3_TMP="/tmp/i3.config.$(whoami)" # per-user

	[[ -f "${I3_NODE_CONFIG}" ]] &&
		cat "${I3_NODE_CONFIG}" >> "${I3_TMP}"
	[[ -f "${I3_CONFIG}" ]] &&
		cat "${I3_CONFIG}" >> "${I3_TMP}"
	exec i3 -c "${I3_TMP}"
	;;
*)
	exec "$DEFAULT_SESSION"
	;;
esac
