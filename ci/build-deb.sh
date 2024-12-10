#!/bin/bash
# shellcheck disable=SC2086,2103,2164

cd "$(dirname "$0")"

# Update packages
apt update && apt upgrade -y

# Install debhelper
yes | apt install -y debhelper cryptsetup pkg-kde-tools pkexec os-prober rsync git wget || :

# Install dependencies
./deps-debian11.sh

current_ver=$(head -1 debian/changelog | grep -Eo '[0-9]+(\.[0-9]+){2,}')

# Clone original
wget https://github.com/calamares/calamares/archive/refs/tags/v${current_ver}.tar.gz -O - | tar -xzf -
mv calamares-${current_ver}/* ..
mv debian ..

cd ..

# Create .orig tarball
tar -cJf ../calamares_${current_ver}.orig.tar.xz .

dpkg-buildpackage -b --no-sign
