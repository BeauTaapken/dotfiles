#!/bin/env bash
source /mnt/crucial-ssd/shell-scripts/.env

# Function
setfan() {
  xhost si:localuser:root
  echo $password | sudo -S /usr/bin/nvidia-settings -a "*:1[gpu:0]/GPUFanControlState=1" -a "*:1[fan-0]/GPUTargetFanSpeed=$1" -a "*:1[fan-1]/GPUTargetFanSpeed=$1"
  xhost -si:localuser:root
}

# Change 'setfan' parameter for speed % and 'X' intervals for temperature boundaries, keep in mind, the minimum value is 30 (cus fuck me for wanting slower fan speed, I guess)
for(( ; ; ))
do
X=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader)
if ((0<=X && X<=39))
then
  setfan 35
elif ((40<=X && X<=44))
then
  setfan 40
elif ((45<=X && X<=49))
then
  setfan 55
elif ((50<=X && X<=100))
then
  setfan 100
fi

sleep 5
done
