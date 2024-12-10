# syntax=docker/dockerfile:1-labs
FROM devuan/migrated:ceres-slim

# Update packages
RUN apt update && apt upgrade -y

# Install debhelper
RUN yes | apt install -y debhelper cryptsetup pkg-kde-tools pkexec os-prober rsync git wget || :

# Clone original
RUN wget https://github.com/calamares/calamares/archive/refs/tags/v3.3.12.tar.gz -O - | tar -C calamares -xzf -

# Apply patches
COPY . /calamares

WORKDIR "/calamares"

# Create .orig tarball
RUN tar -cJf /calamares_3.3.12.orig.tar.xz .

# Install dependencies
RUN ./ci/deps-debian11.sh

# Move debian folder to top
RUN mv ./ci/debian .

RUN dpkg-buildpackage
