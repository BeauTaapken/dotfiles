#!/usr/bin/env bash
START=`date +%s`
while [ $(( $(date +%s) - 40 )) -lt $START ]; do
    xset dpms force standby
done
