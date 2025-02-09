#!/bin/bash
sum=0
for i in {1..10}; do
    if (( i % 2 == 0 )); then
        echo "Adding $i"
        sum=$((sum + i))
    fi
done
echo "Sum of even numbers from 1 to 10 is: $sum"