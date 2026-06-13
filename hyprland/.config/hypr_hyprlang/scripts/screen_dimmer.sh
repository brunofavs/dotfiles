#!/bin/bash

# This script was a attempt at making a gradual dimming with 
# hypridle. It works to an extent but has a major flaw : 
# the while loop won't get interrupted if the system stops being idle while it runs.
# Thus, the on-resume command will restore the initial brightness but this script can still be running
# and keep lowering it. 
#
# Solution : Find a way to detect idle'ness and update the loop condition.
# On X, there is xprintidle. I don't think there is a alternative for Wayland.

threshold=$(( "$( brightnessctl max )"/ 10 ))
initial=$(brightnessctl get)

touch /tmp/current_brightness.txt
echo "$initial" > /tmp/current_brightness.txt

brightnessctl -s

while [[ $(brightnessctl get) -gt $threshold ]]; do
  brightnessctl set 1%-
  echo "Reduced once"
  sleep 0.02
done
