#!/bin/bash
# Author: Shadichy <shadichy.dev@gmail.com>

# Remove btrfs and zfs subvolume mechanism
sed -i -r 's/fstype == "btrfs"/False/g' src/modules/mount/main.py
