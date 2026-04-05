#!/bin/bash
# https://gist.github.com/morkev/3f08cf45f38610565455bf48190b1b7e
# ==============================================================================
# KEYCHRON LINUX FIX FOR HID DEVICE C0NNECTED [K]
# Author: morkev
#
# Contributors:
# - SIMULATAN: Fixed dongle interference by filtering out "Link" devices.
# - karoltheguy: Added SELinux context reset (restorecon) to prevent silent blocks.
# - wanjas: Verified 'input' group addition is required for distros like Pop_OS.
#
# INSTRUCTIONS
#
# Step 1: Open your terminal and create the file:
#   nano fix-keychron.sh
#
# Step 2: Paste this entire script into the nano editor.
#
# Step 3: Save and Exit nano
#   Press Ctrl + O to save.
#   Press Enter to confirm.
#   Press Ctrl + X to exit.
#
# Step 4: Make executable and run
#   chmod +x fix-keychron.sh
#   sudo ./fix-keychron.sh
# ==============================================================================

# --- 1. CHECK WE ARE RUNNING AS ROOT ---
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo: sudo ./fix-keychron.sh"
  exit 1
fi

# --- 2. VARIABLE CONFIGURATION ---
# This will grab the actual user who ran sudo, not the root user
REAL_USER=${SUDO_USER:-$USER}
USER_GROUP=$(id -gn "$REAL_USER")

RULE_FILE="/etc/udev/rules.d/99-keychron.rules"

# --- 3. FIND THE KEYBOARD ---
echo "Looking for Keychron devices..."

# Find the USB device, but ignore the wireless receiver so we grab the actual keyboard.
# (Credit to SIMULATAN for catching the "Link" device bug!)
KEYCHRON_INFO=$(lsusb | grep -i "Keychron" | grep -vi "Link" | head -n 1)

# Make sure we actually found something
if [ -z "$KEYCHRON_INFO" ]; then
    echo "No Keychron keyboard detected. Please ensure it is plugged in via USB."
    exit 1
fi

echo "Found: $KEYCHRON_INFO"

# --- 4. EXTRACT SPECIFIC VENDOR AND PRODUCT IDs ---
VENDOR_ID=$(echo "$KEYCHRON_INFO" | awk '{print $6}' | cut -d':' -f1)
PRODUCT_ID=$(echo "$KEYCHRON_INFO" | awk '{print $6}' | cut -d':' -f2)

echo "Vendor ID: $VENDOR_ID"
echo "Product ID: $PRODUCT_ID"

# --- 5. APPLY UDEV RULES ---
echo "Creating udev rule at $RULE_FILE..."

# Now we will write the rule dynamically based on the detected IDs
cat <<EOF > "$RULE_FILE"
# Keychron Keyboard udev rule for VIA / Keychron Launcher
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="$VENDOR_ID", ATTRS{idProduct}=="$PRODUCT_ID", MODE="0660", GROUP="$USER_GROUP", TAG+="uaccess", TAG+="udev-acl"
EOF

# Reset SELinux context to prevent silent blocks, but only if SELinux tools exist on this distro
# (Credit to karoltheguy for this fix)
if command -v restorecon &> /dev/null; then
    echo "Resetting SELinux context for the udev rule..."
    restorecon -v "$RULE_FILE"
fi

echo "Reloading udev rules..."
udevadm control --reload-rules
udevadm trigger

# --- 6. PERMISSIONS ---
# Add user to the input group so the system actually lets them talk to the board.
# (Credit to wanjas for confirming this is useful for distros like Pop_OS)
echo "Adding $REAL_USER to the 'input' group..."
usermod -aG input "$REAL_USER"

# --- 7. WRAP UP ---
echo "Done! Your Keychron should be good now."
echo "IMPORTANT: Please unplug your keyboard and plug it back in for the changes to take full effect."
