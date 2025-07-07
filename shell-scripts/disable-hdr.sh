if [[ -f "$HOME/.config/hypr/monitors.conf" && ! -f "$HOME/.config/hypr/monitors-hdr.conf" && -f "$HOME/.config/hypr/monitors-sdr.conf" ]]; then
    mv ~/.config/hypr/monitors.conf ~/.config/hypr/monitors-hdr.conf
    mv ~/.config/hypr/monitors-sdr.conf ~/.config/hypr/monitors.conf
    hyprctl reload
fi
