#!/usr/bin/env bash
START=`date +%s`
while [ $(( $(date +%s) - 40 )) -lt $START ]; do
    hyprctl dispatch dpms off
done
