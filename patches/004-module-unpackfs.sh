#!/bin/bash
# Author: Bùi Gia Viện (BlissLabs) <shadichy@blisslabs.org>

# Patches for erofs
sed -i 's|self.sourcefs == "ext4":|self.sourcefs == "ext4" or self.sourcefs == "erofs":|g' src/modules/unpackfs/main.py
