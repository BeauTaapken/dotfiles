#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source ${SCRIPT_DIR}/.env


wattage=$(nvidia-smi -q -d POWER | grep 'Max Power Limit' | grep ' W' | sed -z 's/Max Power Limit                   : //g; s/ W//g;')

# Convert string to int, float isn't supported by bash
# wattageAsInt=$((${wattage%.*} + 0))

# if wattage is a number
# if [[ $wattageAsInt =~ '^[0-9]+$' ]] ; then
echo $password | sudo -S /usr/bin/nvidia-smi -pl $wattage

# Should set gpu memory offset to 1100 at highest performance state (maybe do this for all states? or just wait until a nice tool has been made)
# echo $password | sudo -S /usr/bin/nvidia-settings -a "GPUMemoryTranfserRateOffset[0]"=1100
# fi
