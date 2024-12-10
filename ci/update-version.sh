#!/bin/bash

cd "$(dirname "$0")"

current_ver=$(head -1 debian/changelog | grep -Eo '[0-9]+(\.[0-9]+){2,}')

print_help() {
	echo "USAGE: $0 [-h|VERSION]"
	echo "	While VERSION is x.x.x"
	echo "	Current version is $current_ver"
}

if [ ! "$1" ]; then
	echo "ERROR: No VERSION specified"
	print_help
	exit 1
fi

case "$1" in
-h) print_help && exit 0 ;;
*) ;;
esac

if ! wget --spider "https://github.com/calamares/calamares/archive/refs/tags/v$1.tar.gz" >/dev/null 2>&1; then
	echo "ERROR: Invalid vesion $1"
	exit 1
fi

find . -type f -exec sed -i "s/$current_ver/$1/g" {} +
