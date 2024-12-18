#!/bin/bash
# Author: Bùi Gia Viện (BlissLabs) <shadichy@blisslabs.org>

# Remove btrfs and zfs subvolume mechanism
sed -i -r 's/fstype == "btrfs"/False/g' src/modules/mount/main.py
