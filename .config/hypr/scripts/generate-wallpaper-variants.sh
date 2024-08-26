#!/bin/zsh

###############################
########## WLOGOUT ############
###############################

for entry in ~/.cache/current-wallpaper-*
do
	magick $entry -scale 75% ~/.cache/temp
	magick ~/.cache/temp -fill black -colorize 50% ~/.cache/wlogout-background-${entry##*current-wallpaper-}
	magick ~/.cache/wlogout-background-${entry##*current-wallpaper-} -blur 0x10 ~/.cache/wlogout-background-${entry##*current-wallpaper-}
	rm ~/.cache/temp
done
