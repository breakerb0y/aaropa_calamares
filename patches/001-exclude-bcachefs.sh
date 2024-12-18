#!/bin/bash
# Author: Bùi Gia Viện (BlissLabs) <shadichy@blisslabs.org>

# Remove BCacheFS support (for kpmcore version <= 24)
find src -type f -iname "*.cpp" -exec sed -i -r 's|(.*:Bcachefs:.*)|// \1|gi' {} +
