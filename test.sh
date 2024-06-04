#!/bin/bash

# Define an array of kernel versions
kernels=(4.9 5.10.102 5.15.25 5.16.11 5.16.12 5.17 5.14.10 5.8 5.15.34 6.3.8)

# Print a message indicating that the process has started
echo "Starting kernel vulnerability checks..."

# Start an for loop on each kernel version in the array
for kernel in "${kernels[@]}"
do
    # Print a message indicating that the scan for the current kernel version has begun
    echo "Checking kernel version: $kernel"
    
    # Execute the program dpipe.sh and pass the current kernel version as a parameter
    ./dpipe.sh $kernel
    
    # Check the return status to determine whether the check was successful
    if [[ $? -eq 0 ]]; then
        echo "Kernel version $kernel is not vulnerable."
    else
        echo "Kernel version $kernel is vulnerable."
    fi

    echo "------------------------------------------"
done

# Print a message stating that the process has completed
echo "Kernel vulnerability checks completed."

