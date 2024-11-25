#!/usr/bin/env bash

pushd ~/.config/nvim/
git add .
git commit -m "automatic push"
git push
popd

config='/usr/bin/git --git-dir=/home/beau/.cfg/ --work-tree=/home/beau'

$config add -u
$config commit -m "automatic push"
$config push -u origin main
