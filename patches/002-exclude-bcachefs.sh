#!/bin/bash
# Author: Shadichy <shadichy.dev@gmail.com>

# Remove BCacheFS support (for kpmcore version <= 24)
find src -type f -iname "*.cpp" -exec sed -i -r 's|(.*:Bcachefs:.*)|// \1|gi' {} +
