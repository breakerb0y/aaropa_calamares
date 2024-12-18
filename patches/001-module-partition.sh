#!/bin/bash
# Author: Bùi Gia Viện (BlissLabs) <shadichy@blisslabs.org>

# Patches partition module
find src/modules/partition -type f -iname '*.cpp' -exec sed -i -r 's|/home|/data|g;s|mountPoints\s\{.+\};|mountPoints { "/", "/boot", "/data" };|g' {} +
