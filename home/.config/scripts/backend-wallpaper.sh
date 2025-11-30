#!/usr/bin/bash

img_path=~/Pictures/wallpapers/

# Lista imagens e permite seleção com rofi
selected=$(ls -1 "$img_path" | rofi -dmenu -p "Wallpaper")

# Se algo foi selecionado, aplica wallpaper e pywal
if [ -n "$selected" ]; then
    full_path="$img_path/$selected"
    
    # Aplica pywal para gerar o esquema de cores
    wal -i "$full_path"
    
    # Aplica o wallpaper com swww
    swww img "$full_path"
    
    # Opcional: recarrega aplicações para aplicar as cores
    # pkill waybar && waybar &
    # pkill dunst && dunst &
fi
