#!/bin/bash

# Check if the folder path is provided as an argument
if [ $# -ne 1 ]; then
  echo "Usage: $0 <folder_path>"
  exit 1
fi

folder_path="$1"

# Check if the folder exists
if [ ! -d "$folder_path" ]; then
  echo "Folder '$folder_path' does not exist."
  exit 1
fi

# Get a list of files in the folder
file_list=("$folder_path"/*.json)

# Iterate through each file in the folder
for file in "${file_list[@]}"; do
  # Check if it's a regular file
  if [ -f "$file" ]; then
    # Split the file into smaller parts (adjust the options as needed
	  file_no_extension=$(echo "${file%.*}")
    echo "Spliting '$file' into smaller parts..."
    split -d --bytes=50M --additional-suffix=.json "$file" "$file_no_extension.part" 
    echo "Splited!"

    # Remove file after split
    echo "Removing '$file'"
	  rm $file
    echo "Removed!"
	
  fi
done

echo "Splitting completed."
