# syntax=docker/dockerfile:1-labs
FROM devuan/migrated:ceres-slim

COPY . /blissos-calamares
WORKDIR /blissos-calamares

RUN ./ci/build-deb.sh
