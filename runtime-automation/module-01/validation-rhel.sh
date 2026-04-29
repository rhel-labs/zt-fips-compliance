#!/bin/sh
echo "Validating module-01" >> /tmp/progress.log

if [ ! -f /home/rhel/fips/Containerfile ]; then
    echo "FAIL: ~/fips/Containerfile not found" >> /tmp/progress.log
    echo "HINT: Follow Step 2 to create the standard Python Containerfile" >> /tmp/progress.log
    exit 1
fi

if [ ! -f /home/rhel/fips/Containerfile.fips ]; then
    echo "FAIL: ~/fips/Containerfile.fips not found" >> /tmp/progress.log
    echo "HINT: Follow Step 2 to create the FIPS Python Containerfile" >> /tmp/progress.log
    exit 1
fi

echo "PASS: Both Containerfiles are present" >> /tmp/progress.log
exit 0
