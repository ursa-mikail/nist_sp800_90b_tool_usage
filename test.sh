#!/bin/bash

# Script to create test data and run entropy assessment
# Assumes current directory is /opt/entropy_check/SP800-90B_EntropyAssessment/cpp

echo "=== Entropy Assessment Test Script ==="

# 1. Create test file
echo "Creating test file..."
sudo dd if=/dev/urandom of=./selftest/test_data.bin bs=1000 count=1000

# 2. Check file was created
echo -e "\nChecking file creation..."
ls -la ./selftest/test_data.bin

# 3. Run the test
echo -e "\nRunning entropy assessment..."
./ea_iid ./selftest/test_data.bin 8

echo -e "\n=== Test Complete ==="
