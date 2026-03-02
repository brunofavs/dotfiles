#!/bin/bash

HOSTS_FILE="/etc/hosts"

if [[ ! -f "$HOSTS_FILE" ]]; then
    echo "Error: $HOSTS_FILE not found"
    exit 1
fi

# Read the file into an array
mapfile -t lines < "$HOSTS_FILE"

# Find the last two non-empty lines
last_indices=()
for ((i=${#lines[@]}-1; i>=0; i--)); do
    if [[ -n "${lines[i]}" ]]; then
        last_indices=("$i" "${last_indices[@]}")
        if [[ ${#last_indices[@]} -eq 2 ]]; then
            break
        fi
    fi
done

if [[ ${#last_indices[@]} -lt 2 ]]; then
    echo "Error: Need at least 2 non-empty lines in $HOSTS_FILE"
    exit 1
fi

idx1="${last_indices[0]}"
idx2="${last_indices[1]}"

# Check if both last 2 lines are commented
if [[ "${lines[$idx1]}" =~ ^[[:space:]]*# ]] && [[ "${lines[$idx2]}" =~ ^[[:space:]]*# ]]; then
    # Both are commented, uncomment them
    lines[$idx1]=$(echo "${lines[$idx1]}" | sed 's/^[[:space:]]*#[[:space:]]*//')
    lines[$idx2]=$(echo "${lines[$idx2]}" | sed 's/^[[:space:]]*#[[:space:]]*//')
    echo "Uncommented last 2 lines"
else
    # Comment both lines
    lines[$idx1]="# ${lines[$idx1]}"
    lines[$idx2]="# ${lines[$idx2]}"
    echo "Commented last 2 lines"
fi

# Write back to file
printf '%s\n' "${lines[@]}" | sudo tee "$HOSTS_FILE" > /dev/null

echo "Done!"
