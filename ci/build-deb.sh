#!/bin/bash
# shellcheck disable=SC2086,2103,2164

cd "$(dirname "$0")"

# Update packages
apt update && apt upgrade -y

# Install debhelper
yes | apt install -y debhelper cryptsetup pkg-kde-tools pkexec os-prober rsync git wget || :


current_ver=$(head -1 debian/changelog | grep -Eo '[0-9]+(\.[0-9]+){2,}')

# Clone original
wget https://github.com/calamares/calamares/archive/refs/tags/v${current_ver}.tar.gz -O - | tar -xzf -
cp -rn calamares-${current_ver}/* ..
cp -rf debian ..

rm -rf debian calamares-${current_ver}

# Install dependencies
./deps-debian11.sh

cd ..

# Create .orig tarball
tar -cJf ../blissos-calamares_${current_ver}.orig.tar.xz .

dpkg-buildpackage -b --no-sign
