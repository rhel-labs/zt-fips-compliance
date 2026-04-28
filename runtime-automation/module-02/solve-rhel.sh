#!/bin/sh
echo "Solving module-02" >> /tmp/progress.log
cd ~/fips
podman build -t fips:no -f Containerfile .
podman build -t fips:yes -f Containerfile.fips .
podman run --rm fips:no
podman run --rm fips:yes
