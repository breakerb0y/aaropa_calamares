#!/bin/bash
# Author: Shadichy <shadichy.dev@gmail.com>

# Patches branding name in the Cmake file
sed -i -r 's|calamares_add_branding_subdirectory\(.+\)|calamares_add_branding_subdirectory( blissos )|g' src/branding/CMakeLists.txt
