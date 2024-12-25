#!/bin/bash
# shellcheck disable=2086,2103,2164,2317

cd "$(dirname "$0")"

pkgname=blissos-calamares
_ver=$(head -1 debian/changelog | grep -Eo '[0-9]+(\.[0-9]+){2,}-[0-9]+')
pkgver=$(echo "${_ver}" | awk -F - '{print $1}')
pkgrel=$(echo "${_ver}" | awk -F - '{print $2}')

# avoid command failure
exit_check() { [ "$1" = 0 ] || exit "$1"; }
trap 'exit_check $?' EXIT

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
cat <<EOF >../metadata.yml
Name: ${pkgname}
Version: ${_ver}
Variants: default dbgsym
EOF
