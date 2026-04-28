#!/bin/sh
echo "Solving module-01" >> /tmp/progress.log
cat /proc/sys/crypto/fips_enabled >> /tmp/progress.log

# Write Containerfiles as root before switching to rhel user context
cat > /home/rhel/fips/Containerfile << 'EOF'
FROM registry.access.redhat.com/hi/python:3.14
COPY test-fips.py .
USER ${CONTAINER_DEFAULT_USER}
STOPSIGNAL SIGINT
ENTRYPOINT ["python", "./test-fips.py"]
EOF
cat > /home/rhel/fips/Containerfile.fips << 'EOF'
FROM registry.access.redhat.com/hi/python:3.14-fips
COPY test-fips.py .
USER ${CONTAINER_DEFAULT_USER}
STOPSIGNAL SIGINT
ENTRYPOINT ["python", "./test-fips.py"]
EOF
chown rhel:rhel /home/rhel/fips/Containerfile /home/rhel/fips/Containerfile.fips
