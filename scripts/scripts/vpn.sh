#!/bin/bash

# Path to your VPN folder and credentials file
VPN_FOLDER=~/scripts/vpn
CREDENTIALS_FILE=$VPN_FOLDER/credentials.txt

# Get a random .ovpn file from the folder
OVPN_FILE=$(find "$VPN_FOLDER" -type f -name "*.ovpn" | shuf -n 1)

# Check if a valid .ovpn file is found
if [[ -n "$OVPN_FILE" ]]; then
    echo "Connecting to VPN using: $OVPN_FILE"
    sudo openvpn --config "$OVPN_FILE" --auth-user-pass "$CREDENTIALS_FILE"
else
    echo "No .ovpn files found in the $VPN_FOLDER directory."
fi

            
