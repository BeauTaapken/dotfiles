#!/usr/bin/env bash

tmp_dir="/tmp/cliphist"
rm -rf "$tmp_dir"
mkdir -p "$tmp_dir"

gawk -v tmp="/tmp/cliphist" '
  /^[0-9]+\s<meta http-equiv=/ { next }
  match($0, /^([0-9]+)\s(\[\[\s)?binary.*(jpg|jpeg|png|bmp)/, grp) {
    print $0 "\0icon\x1f" tmp "/" grp[1] "." grp[3];
    next
  }
  { print }
'
