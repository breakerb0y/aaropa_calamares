# syntax=docker/dockerfile:1-labs
FROM devuan/migrated:ceres-slim

# Update packages
RUN apt update && apt upgrade -y

# Install debhelper
RUN yes | apt install -y debhelper cryptsetup pkg-kde-tools pkexec os-prober rsync git || :

# Clone original
RUN git clone --depth 1 https://github.com/calamares/calamares.git

# Apply patches
COPY . /calamares

# Create .orig tarball
RUN tar -cJf calamares_3.3.10.orig.tar.xz calamares

WORKDIR "/calamares"

# Install dependencies
RUN ./ci/deps-debian11.sh

# Move debian folder to top
RUN mv ./ci/debian .

RUN dpkg-buildpackage
