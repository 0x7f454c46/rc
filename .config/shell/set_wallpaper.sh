#!/bin/bash
WALLPAPER_PATH=~/pic/wall
ln -fs "$(find ${WALLPAPER_PATH} -type f | shuf -n 1)" /tmp/wallpaper &&
	feh --bg-scale /tmp/wallpaper &&
	convert /tmp/wallpaper -resize "1920x1200!" /tmp/_wallpaper.png &&
	mv /tmp/_wallpaper.png /tmp/wallpaper.png
