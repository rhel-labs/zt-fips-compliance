#!/bin/sh
echo "Validating module-02" >> /tmp/progress.log

if ! runuser -u rhel -- podman image exists localhost/fips:yes 2>/dev/null; then
    echo "FAIL: fips:yes image not found" >> /tmp/progress.log
    echo "HINT: Did you complete Step 3 to build the fips:yes image?" >> /tmp/progress.log
    exit 1
fi

if ! runuser -u rhel -- podman image exists localhost/fips:no 2>/dev/null; then
    echo "FAIL: fips:no image not found" >> /tmp/progress.log
    echo "HINT: Did you complete Step 3 to build the fips:no image?" >> /tmp/progress.log
    exit 1
fi

OUTPUT=$(runuser -u rhel -- podman run --rm fips:yes 2>&1)
if echo "$OUTPUT" | grep -q "FIPS CAPABLE"; then
    echo "PASS: fips:yes image enforces FIPS algorithm restrictions" >> /tmp/progress.log
    exit 0
else
    echo "FAIL: fips:yes output does not show FIPS CAPABLE" >> /tmp/progress.log
    echo "HINT: Check that Containerfile.fips uses the python:3.14-fips base image" >> /tmp/progress.log
    exit 1
fi
