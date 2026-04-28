#!/bin/sh
# Validate module-01 completion: test script present, both python images available, Containerfiles written

if [ ! -f ~/fips/test-fips.py ]; then
    echo "FAIL: ~/fips/test-fips.py not found"
    echo "HINT: The test script should have been placed there during lab setup"
    exit 1
fi

if ! podman image exists registry.access.redhat.com/hi/python:3.14; then
    echo "FAIL: python:3.14 image not found"
    echo "HINT: The image should have been pre-pulled during lab setup"
    exit 1
fi

if ! podman image exists registry.access.redhat.com/hi/python:3.14-fips; then
    echo "FAIL: python:3.14-fips image not found"
    echo "HINT: The FIPS image should have been pre-pulled during lab setup"
    exit 1
fi

if [ ! -f ~/fips/Containerfile ]; then
    echo "FAIL: ~/fips/Containerfile not found"
    echo "HINT: Run the commands in Step 2 to create the standard Containerfile"
    exit 1
fi

if [ ! -f ~/fips/Containerfile.fips ]; then
    echo "FAIL: ~/fips/Containerfile.fips not found"
    echo "HINT: Run the commands in Step 2 to create the FIPS Containerfile"
    exit 1
fi

echo "PASS: test-fips.py present, both python images available, both Containerfiles written"
exit 0
