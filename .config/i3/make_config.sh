#!/bin/sh
#
#   This file combines general i3 config placed in ~/.config/i3/config
# with node config from ~/.config/_node/<node name>/i3/config.
# It places resulting config in /tmp/i3.config.<user>
# This script should run from .xinitrc before starting i3 and
# on i3 reload/restart actions (for re-reading new tmp i3 config).

[[ -f ~/.config/shell/include ]] &&
	source ~/.config/shell/include

GENERIG_CONFIG=~/.config/i3/config
NODE_CONFIG=${NODE_PATH}/.config/i3/config
OUT_CONFIG=/tmp/i3.config.$(whoami)

echo > "${OUT_CONFIG}"

[[ -f "${NODE_CONFIG}" ]] &&
	cat "${NODE_CONFIG}" >> "${OUT_CONFIG}"
[[ -f "${GENERIG_CONFIG}" ]] &&
	cat "${GENERIG_CONFIG}" >> "${OUT_CONFIG}"

echo "${OUT_CONFIG}"
