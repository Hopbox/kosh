#!/bin/bash
type="categories" # These are all catagories for services
rsync -arpogvt rsync://ftp.ut-capitole.fr/blacklist .
cd dest
ls -d */ | while read line; do
    # Extract the file name from the list
    dir_name=${line%/}        
    #Check if folder already exists, create it if not
    if [ ! -d "../${type}/${dir_name}" ]; then
            mkdir -p "../${type}/${dir_name}"
    fi  
        # Sed using extened regex to invert match ips and there ranges while removing spaces and coments of the file if any  
        output=$(sed -rn '/((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])/!p ;s/\s*#.*//g ;/^$/ d' ${dir_name}/domains)
        if [ -n "$output" ]; then
            echo "$output" >> "../${type}/${dir_name}/domains"
        fi
        # Remove Duplicates from the files if added any
        awk -i inplace '!seen[$0]++' ../${type}/${dir_name}/domains

        # Sed using extened regex to get ips and there ranges while removing spaces and coments of the file if any     
        output=$(sed -rn '/((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])/p ;s/\s*#.*//g ;/^$/ d' ${dir_name}/domains)
        if [ -n "$output" ]; then
            echo "$output" >> ""../${type}/${dir_name}/ip""
        fi
        # Remove Duplicates from the files if added any
        awk -i inplace '!seen[$0]++' ../${type}/${dir_name}/ip
done