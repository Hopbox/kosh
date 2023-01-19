#!/bin/bash

# Check arguments
if [ "$1" = "-c" ]; then
    type="categories"
elif [ "$1" = "-a" ]; then
    type="apps"
else
    echo "Invalid argument provided."
    echo "-c categories -a apps"
fi

ls *.txt | while read line; do
    # Extract the file name from the list
    dir_name=${line%.txt}
        
   # Check if folder already exists, create it if not
    if [ ! -d "../kosh/${type}/${dir_name}" ]; then
            mkdir -p "../kosh/${type}/${dir_name}"
    fi       
        sed ' s/0\.0\.0\.0 // ;s/\s*#.*//g ;/^$/ d ' $line >> "../kosh/${type}/${dir_name}/domains"
        # Remove Duplicates from the files if added any
        pwd
        awk -i inplace '!seen[$0]++' ../kosh/${type}/${dir_name}/domains    
        line = ""

ls *.ip | while read line; do
    # Extract the file name from the list
    dir_name=${line%.ip}
        
   # Check if folder already exists, create it if not
    if [ ! -d "../kosh/${type}/${dir_name}" ]; then
            mkdir -p "../kosh/${type}/${dir_name}"
    fi       
        sed 's/\s*#.*//g; /^$/ d' $line >> "../kosh/${type}/${dir_name}/ip"
        # Remove Duplicates from the files if added any
        pwd
        awk -i inplace '!seen[$0]++' ../kosh/${type}/${dir_name}/domains
    done
done