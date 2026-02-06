# SP800-90B Entropy Assessment Tool
A comprehensive tool for estimating min-entropy of random number generators and noise sources, implementing NIST SP800-90B statistical tests.

# Basic Installation and Test

```
#!/bin/bash

# Update system and install dependencies
sudo apt-get update
sudo apt-get install -y build-essential git g++ make \
    libbz2-dev libjsoncpp-dev libssl-dev \
    libgmp-dev libmpfr-dev libdivsufsort-dev

# Clone repository
git clone https://github.com/usnistgov/SP800-90B_EntropyAssessment.git

# Build the tools
cd SP800-90B_EntropyAssessment/cpp
make clean
make

# Verify installation
cd selftest
./selftest
```

# Creating Test Data
```
# Generate 1MB of test data from /dev/urandom
dd if=/dev/urandom of=test_data.bin bs=1000 count=1000

# Generate 10MB for more reliable results
dd if=/dev/urandom of=large_test.bin bs=10M count=1
```

# Run Entropy Assessment
```
# ./ea_iid <data_file> <bits_per_symbol>
./ea_iid test_data.bin 8


# Create test data
dd if=/dev/urandom of=sample.bin bs=1M count=1

# Run self-test (always do this first)
cd selftest && ./selftest

# Run IID assessment
cd ..
./ea_iid sample.bin 8

# Run non-IID assessment
./ea_non_iid sample.bin 8


# 1-bit data (single bitstream)
./ea_iid bitstream.bin 1

# 4-bit data (nibbles from ADC)
./ea_non_iid adc_data.bin 4

# 12-bit data (common for sensors)
./ea_iid sensor_data.bin 12

# 16-bit data
./ea_non_iid audio_samples.bin 16

```

# Sample steps

```
!git clone https://github.com/usnistgov/SP800-90B_EntropyAssessment.git
!tar -czf SP800-90B_EntropyAssessment.tar.gz SP800-90B_EntropyAssessment
!ls -al /content/SP800-90B_EntropyAssessment
!sudo apt-get update
!sudo apt-get install -y build-essential git g++ make libbz2-dev libjsoncpp-dev libssl-dev libgmp-dev libmpfr-dev libdivsufsort-dev
!sudo mkdir -p /opt/entropy_check
!sudo cp -r /content/SP800-90B_EntropyAssessment /opt/entropy_check/

!cd /opt/entropy_check/SP800-90B_EntropyAssessment/cpp && make clean
!cd /opt/entropy_check/SP800-90B_EntropyAssessment/cpp && make

!cd /opt/entropy_check/SP800-90B_EntropyAssessment/cpp/selftest && chmod +x selftest 2>/dev/null
!cd /opt/entropy_check/SP800-90B_EntropyAssessment/cpp/selftest && ./selftest 2>&1

"""
biased-random-bits.bin: Maximum delta: 4.18241830058008e-14
biased-random-bytes.bin: Maximum delta: 4.24382751162966e-14
data.pi.bin: Maximum delta: 4.32986979603811e-15
normal.bin: Maximum delta: 3.5527136788005e-15
rand1_short.bin: Maximum delta: 4.77395900588817e-15
rand4_short.bin: Maximum delta: 2.44249065417534e-15
rand8_short.bin: Maximum delta: 7.7715611723761e-16
ringOsc-nist.bin: Maximum delta: 5.60662627435704e-15
truerand_1bit.bin: Maximum delta: 5.30686605770825e-14
truerand_4bit.bin: Maximum delta: 3.47499806707674e-14
truerand_8bit.bin: Maximum delta: 1.00808250635964e-13
"""

# 1. Create test file
!sudo dd if=/dev/urandom of=/opt/entropy_check/SP800-90B_EntropyAssessment/cpp/selftest/test_data.bin bs=1000 count=1000

# 2. Check file was created
!ls -la /opt/entropy_check/SP800-90B_EntropyAssessment/cpp/selftest/test_data.bin

# 3. Run the test
!cd /opt/entropy_check/SP800-90B_EntropyAssessment/cpp && ./ea_iid ./selftest/test_data.bin 8

"""
1000+0 records in
1000+0 records out
1000000 bytes (1.0 MB, 977 KiB) copied, 0.00508546 s, 197 MB/s
-rw-r--r-- 1 root root 1000000 Feb  6 21:03 /opt/entropy_check/SP800-90B_EntropyAssessment/cpp/selftest/test_data.bin
Calculating baseline statistics...
H_original: 7.868553
H_bitstring: 0.998178
min(H_original, 8 X H_bitstring): 7.868553
** Passed chi square tests

** Passed length of longest repeated substring test

** Passed IID permutation tests
"""
```

You can also run a test script:

```
%cd /opt/entropy_check/SP800-90B_EntropyAssessment/cpp
!pwd

```

```
%%writefile test.sh
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
```

```
!chmod +x test.sh
!./test.sh
```

