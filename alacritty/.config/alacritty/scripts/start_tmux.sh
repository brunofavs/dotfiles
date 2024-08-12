#!/bin/bash

BASE_SESSION_NAME="ubuntu"

# Function to generate the next available session name
generate_session_name() {
    local session_name
    local counter=1

    while true; do
        session_name="${BASE_SESSION_NAME}${counter}"
        tmux has-session -t "${session_name}" 2>/dev/null
        if [ $? != 0 ]; then
            echo "${session_name}"
            return
        fi
        ((counter++))
    done
}

# Generate a new session name
SESSION_NAME=$(generate_session_name)

# Create a new tmux session with the generated name and run the desired command
exec tmux new-session -s "${SESSION_NAME}" 'source ~/.enter_ubuntu; $SHELL'

# Attach to the new session
# tmux attach -t "${SESSION_NAME}"
