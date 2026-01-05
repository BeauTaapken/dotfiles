#!/bin/zsh

# all wallpapers array
wallpapers=(~/Pictures/Wallpapers/*)

current_wallpaper_path=$(awww query | sed "s/.*image: \(.*\)/\1/") 

if [[ $current_wallpaper_path == "" ]] then;
    awww-daemon &!
fi

current_wallpaper_name=${current_wallpaper_path:t}

selected_wallpaper=$(for a in $wallpapers; do
    if [[ ${a:t} == $current_wallpaper_name ]] then;
        echo -en "${a:t} (current)\0icon\x1f$a\n"
    else
        echo -en "${a:t}\0icon\x1f$a\n"
    fi
done | rofi -dmenu -p " " -theme /styles/awww.rasi)

final_wallpaper=$(echo $selected_wallpaper | sed "s/ (current)//")
wallpaper_ext=$(echo $final_wallpaper | sed "s/.*\.\(.*\)/\1/")

if [[ $selected_wallpaper != "" ]]; then
    monitor=$(hyprctl activeworkspace | grep -o "monitor .*" | sed -n 's/monitor //; s/://p')
    awww img ~/Pictures/Wallpapers/$final_wallpaper -o $monitor --transition-type center --transition-fps 60 --transition-step 100 &&
    ln -f ~/Pictures/Wallpapers/$final_wallpaper ~/.cache/current-wallpaper-$monitor && # creates a symlink to the current wallpaper
    ~/.config/hypr/scripts/generate-wallpaper-variants.sh # generates all the variants at a single time
fi
