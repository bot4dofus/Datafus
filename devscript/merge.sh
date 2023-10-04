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

# Get a list of split files in the folder
split_files=("$folder_path"/*.part*)

# Iterate through each split file
for split_file in "${split_files[@]}"; do
  # Check if it's a split file
  if [ -f "$split_file" ]; then
    # Determine the original file name without the ".part" suffix
    original_file="${split_file%.part*}"
    echo "Merging '$split_file' into '$original_file'..."
    cat "$split_file" >> "$original_file.json"
    echo "Merged!"
    
    # Remove the split part file after merging
    echo "Removing '$split_file'"
    rm "$split_file"
    echo "Removed!"

  fi
done

echo "Merging completed."
