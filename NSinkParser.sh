#!/bin/bash
# Check if input file is provided
if [ -z "$1" ]; then
  echo "Error: Input file not provided"
  exit 1
fi

# Check if input file exists
if [ ! -f "$1" ]; then
  echo "Error: Input file not found"
  exit 1
fi

cat "$1" | while read line; do
  # Extract the folder name using regular expressions
  dir_name=$(echo "$line" | sed ' s/\s*#.*//g ;/^$/ d ' |grep -oP '[^\.]+$')
  #Check if line starts with host or ip
  if [[ $line == host* ]]; then
        # Extract the domain name using regular expressions
        ip="" # Just to ensure there is no previous data
        domain=$(echo "$line" | awk -F\" '{print $4}' | sed 's/^\.// ; s/\$$//')
  
  elif [[ $line == ip* ]]; then
        # Extract the IP address and subnet using regular expressions
        domain="" # Just to ensure there is no previous data
        ip=$(echo "$line" | grep -oP 'ip:[^,@]+' | sed 's/^ip://')
  fi

  # Check if folder already exists, create it if not
  if [ ! -d "./apps/${dir_name}" ]; then
        mkdir -p "./apps/${dir_name}"
  fi

  # Check if file already exists, create it if not and append the domain or IP and subnet
  #if [ ! -f "./apps/${dir_name}/domains" ]; then
   # echo "$domain" > "./apps/${dir_name}/domains"
  #else
    if [ -n "$domain" ]; then
        echo "$domain" >> "./apps/${dir_name}/domains"
        # Remove Duplicates from the files if added any
        awk -i inplace '!seen[$0]++' ./apps/${dir_name}/domains
    fi
  #fi

  #if [ ! -f "./apps/${dir_name}/ip" ]; then
   # echo "$ip" > "./apps/${dir_name}/ip"
  #else
    if [ -n "$ip" ]; then
        echo "$ip" >> "./apps/${dir_name}/ip"
        # Remove Duplicates from the files if added any
        awk -i inplace '!seen[$0]++' ./apps/${dir_name}/ip
    fi
  #fi
done