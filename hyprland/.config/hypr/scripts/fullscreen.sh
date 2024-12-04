#!/bin/bash

if [ "$(hyprctl activeworkspace -j | jq -r .windows)" -gt 1 ]; then
  hyprctl dispatch fullscreen 1
  echo "Fullscreen 0"
fi
