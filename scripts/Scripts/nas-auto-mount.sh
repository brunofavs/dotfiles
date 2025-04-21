#!/bin/bash

# The IP address to ping
IP="192.168.1.141"

# The script to execute when ping is successful for the first time
MOUNT_SCRIPT="$HOME/Scripts/nas-mount.sh"

# The script to execute when ping fails after initial success
UNMOUNT_SCRIPT="$HOME/Scripts/nas-mount.sh -u"

# A flag to indicate whether the first script has been executed
is_nas_mounted=false

while true; do
  # Ping the IP once and check if it was successful
  if ping -c 1 $IP &> /dev/null; then
  # if the ping command outputs data

    if [ "$is_nas_mounted" = false ]; then
      echo "Ping successful for the first time! Executing the success script..."
      bash $MOUNT_SCRIPT
      is_nas_mounted=true  # Set the flag to true after the script is executed
    else
      echo "Ping successful, but success script has already been executed. Doing nothing."
    fi

  else
  # if the ping command doesn't output anything 
    if [ "$is_nas_mounted" = true ]; then
      echo "Ping failed after initial success! Executing the failure script..."
      bash $UNMOUNT_SCRIPT
      is_nas_mounted=false  # Reset the flag if the ping fails again
    else
      echo "Ping failed, waiting for the next cycle..."
    fi
  fi
  
  # Wait for 60 seconds before the next check
  sleep 60
done
