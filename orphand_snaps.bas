#!/bin/bash

#-------------------------------------------------------------------------------
# Description: Find and removes orphaned snap packages on a Linux system, unless they serve as a default provider for another snap package
# Licensing: This code is released under the MIT License. For more information, see <https://opensource.org/licenses/MIT>.
# Copyright (c) 2024 Mario Herrmann. All rights reserved.
#-------------------------------------------------------------------------------

orphan=$(snap connections --all | grep 'content' | grep -v 'themes' | grep -v'slot' | awk '$2 == "-" {print $3}' | cut -d: -f1)
provider=$(sudo find /snap -name "snap.yaml" | while read i; do grep -E "default-provider:" "$i" | cut -d: -f2; done)
plug=$(snap connections $orphan | grep 'content' | awk '$2!= "-" {print $2}' | cut -d: -f1)

if [ -z "$orphan" ]; then
    echo "No orphaned snaps found" 
  elif [[ $provider =~ $orphan ]]; then    
      echo "Snap $orphan has no dependencies, but it is the default provider for snap $plug and therefore cannot be uninstalled."
    else
      sudo snap remove $orphan
fi
