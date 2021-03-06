#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

[[ -f ~/.config/shell/include ]] &&
	source ~/.config/shell/include

SYS_RESOURCES=/etc/X11/xinit/.Xresources
SYS_MODMAP=/etc/X11/xinit/.Xmodmap
USER_RESOURCES=~/.Xresources
USER_NODE_RESOURCES=${NODE_PATH}/.Xresources
USER_NODE_THEME=${NODE_PATH}/.Xtheme
URXVT_KEYSYM=~/.config/Xresources.urxvt

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
[[ -f "${URXVT_KEYSYM}" ]] &&
	xrdb -merge "${URXVT_KEYSYM}"

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

./.config/shell/set_wallpaper.sh
exec_wm
exec_wm "${DEFAULT_SESSION}"
