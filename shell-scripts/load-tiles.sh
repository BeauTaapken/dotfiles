#!/bin/bash

while read k; do
    echo "[$k]"
#   hyprctl dispatch exec "[$k]"
done < ~/.savedtiles
