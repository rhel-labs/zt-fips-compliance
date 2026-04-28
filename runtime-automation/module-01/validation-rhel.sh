#!/bin/sh
echo "Validating module-01" >> /tmp/progress.log

if [ ! -f /home/rhel/fips/test-fips.py ]; then
    echo "FAIL: ~/fips/test-fips.py not found" >> /tmp/progress.log
    echo "HINT: The test script should have been placed there during lab setup" >> /tmp/progress.log
    exit 1
fi

if ! runuser -u rhel -- podman image exists registry.access.redhat.com/hi/python:3.14; then
    echo "FAIL: python:3.14 image not found" >> /tmp/progress.log
    echo "HINT: The image should have been pre-pulled during lab setup" >> /tmp/progress.log
    exit 1
fi

if ! runuser -u rhel -- podman image exists registry.access.redhat.com/hi/python:3.14-fips; then
    echo "FAIL: python:3.14-fips image not found" >> /tmp/progress.log
    echo "HINT: The FIPS image should have been pre-pulled during lab setup" >> /tmp/progress.log
    exit 1
fi

if [ ! -f /home/rhel/fips/Containerfile ]; then
    echo "FAIL: ~/fips/Containerfile not found" >> /tmp/progress.log
    echo "HINT: Run the commands in Step 2 to create the standard Containerfile" >> /tmp/progress.log
    exit 1
fi

if [ ! -f /home/rhel/fips/Containerfile.fips ]; then
    echo "FAIL: ~/fips/Containerfile.fips not found" >> /tmp/progress.log
    echo "HINT: Run the commands in Step 2 to create the FIPS Containerfile" >> /tmp/progress.log
    exit 1
fi

echo "PASS: test-fips.py present, both python images available, both Containerfiles written" >> /tmp/progress.log
exit 0
