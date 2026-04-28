#!/bin/bash
USER=rhel

echo "Adding wheel" > /root/post-run.log
usermod -aG wheel rhel

echo "Starting setup for zt-fips-compliance" > /tmp/progress.log

chmod 666 /tmp/progress.log

# Fetch setup files
TMPDIR=/tmp/lab-setup-$$
git clone --single-branch --branch ${GIT_BRANCH:-main} --no-checkout \
  --depth=1 --filter=tree:0 ${GIT_REPO} $TMPDIR
git -C $TMPDIR sparse-checkout set --no-cone /setup-files
git -C $TMPDIR checkout
SETUP_FILES=$TMPDIR/setup-files

# Create fips working directory
mkdir -p /home/rhel/fips

# Copy test script
cp $SETUP_FILES/fips/test-fips.py /home/rhel/fips/test-fips.py
echo "Test script copied" >> /tmp/progress.log

# Pre-pull FIPS and standard Python images into rhel's rootless store
su -l rhel -c "podman pull registry.access.redhat.com/hi/python:3.14"
su -l rhel -c "podman pull registry.access.redhat.com/hi/python:3.14-fips"
echo "Python images pre-pulled" >> /tmp/progress.log

rm -rf $TMPDIR
chown -R rhel:rhel /home/rhel

echo "Setup complete" >> /tmp/progress.log
