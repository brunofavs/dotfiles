#!/bin/bash

# Get the current power profile
current_profile=$(powerprofilesctl get)

# Check if the profile is "power-saver"
if [ "$current_profile" == "power-saver" ]; then
    echo "Power profile is power-saver. Executing command..."
    powerprofilesctl set performance
elif [ "$current_profile" == "performance" ]; then
    echo "Power profile is performance. Executing different command..."
    powerprofilesctl set power-saver
fi
