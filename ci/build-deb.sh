#!/bin/bash
# shellcheck disable=SC2086,2103,2164

cd "$(dirname "$0")"

pkgname=blissos-calamares
pkgver=$(head -1 debian/changelog | grep -Eo '[0-9]+(\.[0-9]+){2,}')

# Update packages
apt update && apt upgrade -y

# Install debhelper
yes | apt install -y debhelper cryptsetup pkg-kde-tools pkexec os-prober rsync git wget || :

# Clone original
wget https://github.com/calamares/calamares/archive/refs/tags/v${pkgver}.tar.gz -O - | tar -xzf -
cp -rn calamares-${pkgver}/* ..
cp -rf debian ..

rm -rf debian calamares-${pkgver}

# Install dependencies
./deps-debian11.sh

cd ..

# Create .orig tarball
tar -cJf ../${pkgname}_${pkgver}.orig.tar.xz .

dpkg-buildpackage -b --no-sign

# export metadata
cat<<EOF>../metadata.yml
Name: $pkgname
Version: $pkgver
Variants: dbgsym
EOF
