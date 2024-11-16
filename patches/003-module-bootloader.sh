#!/bin/bash
# Author: Shadichy <shadichy.dev@gmail.com>

# Remove btrfs and zfs subvolume mechanism
sed -i -r 's/(def is_(btrfs|zfs)_root\(partition\):)/\1\n    return False/g' src/modules/bootloader/main.py
