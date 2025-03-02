#!/bin/bash
set -e

new_hostname="${1?Usage: $0 <hostname>}"
ssh_config="$HOME/.ssh/config"

# Check if the SSH config file exists
if [ ! -f "$ssh_config" ]; then
  echo "Error: SSH config file not found at $ssh_config"
  exit 1
fi

# Use sed to replace the HostName in the pace-interactive block
sed -i "/Host pace-interactive/,/ProxyJump pace/ {
  /HostName/ s/HostName.*/HostName $new_hostname/
}" "$ssh_config"

cat $ssh_config
