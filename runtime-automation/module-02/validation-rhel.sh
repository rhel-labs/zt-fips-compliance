#!/bin/sh
# Validate module-02 completion: both images built, fips:yes enforces FIPS restrictions

if ! podman image exists localhost/fips:yes; then
    echo "FAIL: fips:yes image not found"
    echo "HINT: Run 'podman build -t fips:yes -f ~/fips/Containerfile.fips ~/fips' to build it"
    exit 1
fi

if ! podman image exists localhost/fips:no; then
    echo "FAIL: fips:no image not found"
    echo "HINT: Run 'podman build -t fips:no -f ~/fips/Containerfile ~/fips' to build it"
    exit 1
fi

OUTPUT=$(podman run --rm fips:yes 2>&1)
if echo "$OUTPUT" | grep -q "FIPS CAPABLE"; then
    echo "PASS: fips:yes image enforces FIPS algorithm restrictions"
    exit 0
else
    echo "FAIL: fips:yes output does not show FIPS CAPABLE"
    echo "$OUTPUT"
    exit 1
fi
