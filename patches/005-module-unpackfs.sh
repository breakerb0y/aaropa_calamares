#!/bin/bash
# Author: Shadichy <shadichy.dev@gmail.com>

# Patches for erofs
sed -i 's|self.sourcefs == "ext4":|self.sourcefs == "ext4" or self.sourcefs == "erofs":|g' src/modules/unpackfs/main.py
