if [[ -f "$HOME/.config/hypr/monitors.conf" && -f "$HOME/.config/hypr/monitors-hdr.conf" && ! -f "$HOME/.config/hypr/monitors-sdr.conf" ]]; then
    mv ~/.config/hypr/monitors.conf ~/.config/hypr/monitors-sdr.conf
    mv ~/.config/hypr/monitors-hdr.conf ~/.config/hypr/monitors.conf
    hyprctl reload
fi
