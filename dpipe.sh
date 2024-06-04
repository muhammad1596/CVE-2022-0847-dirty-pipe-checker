#!/bin/bash
# usage:
# Check current kernel: ./dpipe.sh
# Check specific kernel: ./dpipe.sh 5.10.102

# Initialize the first variable which name is kernel
kernel=$1

# Extract the three parts from the kernel version
# If kernel version is not provided as a parameter, the current kernel version is used
ver1=$(echo ${kernel:-$(uname -r | cut -d '-' -f1)} | cut -d '.' -f1)
ver2=$(echo ${kernel:-$(uname -r | cut -d '-' -f1)} | cut -d '.' -f2)
ver3=$(echo ${kernel:-$(uname -r | cut -d '-' -f1)} | cut -d '.' -f3)

# Show detailed kernel version
echo "Kernel version parts: major=$ver1, minor=$ver2, patch=$ver3"

# Check conditions to determine whether the kernel is vulnerable or not
if (( ${ver1:-0} < 5 )); then
    echo "Kernel version is less than 5. Not vulnerable."
    exit 0
elif (( ${ver1:-0} > 5 )); then
    echo "Kernel version is greater than 5. Not vulnerable."
    exit 0
elif (( ${ver1:-0} == 5 && ${ver2:-0} < 8 )); then
    echo "Kernel version is 5.x where x is less than 8. Not vulnerable."
    exit 0
elif (( ${ver1:-0} == 5 && ${ver2:-0} == 10 && ${ver3:-0} == 102 )); then
    echo "Kernel version is exactly 5.10.102. Not vulnerable."
    exit 0
elif (( ${ver1:-0} == 5 && ${ver2:-0} == 10 && ${ver3:-0} == 92 )); then
    echo "Kernel version is exactly 5.10.92. Not vulnerable."
    exit 0
elif (( ${ver1:-0} == 5 && ${ver2:-0} == 15 && ${ver3:-0} == 25 )); then
    echo "Kernel version is exactly 5.15.25. Not vulnerable."
    exit 0
elif (( ${ver1:-0} == 5 && ${ver2:-0} >= 16 && ${ver3:-0} >= 11 )); then
    echo "Kernel version is 5.16.x where x is 11 or greater. Not vulnerable."
    exit 0
elif (( ${ver1:-0} == 5 && ${ver2:-0} > 16 )); then
    echo "Kernel version is 5.y where y is greater than 16. Not vulnerable."
    exit 0
else
    echo "Kernel version is potentially vulnerable."
    exit 1
fi

