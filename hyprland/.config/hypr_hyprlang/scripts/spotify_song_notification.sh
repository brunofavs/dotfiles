#!/bin/bash

# Wait for track to actually change by comparing with current track ID
# This ensures we get the new track info, not the old one
# This is because playerctl runs asynchronously and may not have updated metadata immediately after the track changes
old_track_id=$(playerctl metadata mpris:trackid 2>/dev/null)
max_attempts=10
attempt=0

while [ $attempt -lt $max_attempts ]; do
    sleep 0.05
    new_track_id=$(playerctl metadata mpris:trackid 2>/dev/null)
    if [ "$new_track_id" != "$old_track_id" ] && [ -n "$new_track_id" ]; then
        break
    fi
    attempt=$((attempt + 1))
done

# Get song metadata using playerctl
artist=$(playerctl metadata artist 2>/dev/null)
title=$(playerctl metadata title 2>/dev/null)
album_art_url=$(playerctl metadata mpris:artUrl 2>/dev/null)

# Check if playerctl is running and metadata is available
if [ -z "$artist" ] || [ -z "$title" ]; then
    notify-send -t 1400 -e "Music Player" "No song currently playing"
    exit 0
fi

# Download album art if available
if [ -n "$album_art_url" ]; then
    # Create temp directory if it doesn't exist
    temp_dir="/tmp/spotify_covers"
    mkdir -p "$temp_dir"
    
    # Extract filename from URL and create temp file path
    cover_file="$temp_dir/current_cover.jpg"
    
    # Download the album art
    if [[ "$album_art_url" == file://* ]]; then
        # Local file, just copy it
        cp "${album_art_url#file://}" "$cover_file" 2>/dev/null
    else
        # Remote URL, download it
        curl -s -L "$album_art_url" -o "$cover_file" 2>/dev/null
    fi
    
    # Send notification with album art
    if [ -f "$cover_file" ]; then
        notify-send -t 1400 -e -i "$cover_file" "Now Playing" "$title\n$artist"
    else
        notify-send -t 1400 -e "Now Playing" "$title\n$artist"
    fi
else
    # No album art available, send notification without it
    notify-send -t 1400 -e "Now Playing" "$title\n$artist"
fi
