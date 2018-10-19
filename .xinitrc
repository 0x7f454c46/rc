#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

[[ -f ~/.config/shell/include ]] &&
	source ~/.config/shell/include

WALLPAPER_PATH="pic/wall"
# or set explicitly with WALLPAPER="1.jpg"
[[ -f "${WALLPAPER_PATH}" ]] &&
	WALLPAPER="$(ls "$WALLPAPER_PATH" -1 | sort --random-sort | head -1)"

SYS_RESOURCES=/etc/X11/xinit/.Xresources
SYS_MODMAP=/etc/X11/xinit/.Xmodmap
USER_RESOURCES=~/.Xresources
USER_NODE_RESOURCES=${NODE_PATH}/.Xresources
USER_NODE_THEME=${NODE_PATH}/.Xtheme

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

# $1 - name of window manager
# Will exec and never return if there is such wm.
# Returns if there is no such wm.
function exec_wm()
{
	case $1 in
	i3)
		I3_CONFIG="$(~/.config/i3/make_config.sh)"

		exec i3 -c "${I3_CONFIG}"
		;;
	esac
}

exec_wm
exec_wm "${DEFAULT_SESSION}"
