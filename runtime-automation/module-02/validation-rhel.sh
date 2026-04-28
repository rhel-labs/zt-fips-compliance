#!/bin/sh
echo "Validating module-02" >> /tmp/progress.log

if ! runuser -u rhel -- podman image exists localhost/fips:yes; then
    echo "FAIL: fips:yes image not found" >> /tmp/progress.log
    echo "HINT: Run 'podman build -t fips:yes -f ~/fips/Containerfile.fips ~/fips' to build it" >> /tmp/progress.log
    exit 1
fi

if ! runuser -u rhel -- podman image exists localhost/fips:no; then
    echo "FAIL: fips:no image not found" >> /tmp/progress.log
    echo "HINT: Run 'podman build -t fips:no -f ~/fips/Containerfile ~/fips' to build it" >> /tmp/progress.log
    exit 1
fi

OUTPUT=$(runuser -u rhel -- podman run --rm fips:yes 2>&1)
if echo "$OUTPUT" | grep -q "FIPS CAPABLE"; then
    echo "PASS: fips:yes image enforces FIPS algorithm restrictions" >> /tmp/progress.log
    exit 0
else
    echo "FAIL: fips:yes output does not show FIPS CAPABLE" >> /tmp/progress.log
    echo "$OUTPUT" >> /tmp/progress.log
    exit 1
fi
