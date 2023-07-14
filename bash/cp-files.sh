#!/bin/bash

echo "============= Testing copy ======================="


array_contains() {
    local target="$1"
    shift
    local array=("$@")
  
    for element in "${array[@]}"; do
        echo "***** testing if: $element EQUALS $target"
        if [ "$element" == "$target" ]; then
            echo "***** found: $target in array"
            return 0  # Return success status (found)
        fi
    done

    echo "***** NOT found: $target in array"
    return 1  # Return failure status (not found)
}

print_a


source_dir="/c/tmp/source"
destination_dir="/c/tmp/target"

exclude_folders=("exclude_folder_1" "exclude_folder_2")
exclude_files=("exclude_file_1" "exclude_file_2")

copy_recursive() {

    local source="$1"
    shift
    local destination=("$@")

    echo "============================= source: $source"
    echo "============================= destination: $destination"
    for element in "${exclude_folders[@]}"; do
        echo "$element"
    done
    for element in "${exclude_files[@]}"; do
        echo "$element"
    done

    # local source="$source_dir"
    # local destination="$destination_dir"
    # local exclude_folder
    # local exclude_file

    # Copy files from source to destination, excluding specified folders and files
    for file in "$source"/*; do
        echo "========================================: $file"
        if [ -d "$file" ]; then
            # Check if folder should be excluded, name only!
            local folder_name="$(basename "$file")"
            if array_contains "$folder_name" "${exclude_folders[@]}"; then
                echo "111111111111111111111 Skipping excluded folder: $folder_name"
                continue
            else
                local subfolder="$destination/$(basename "$file")"
                mkdir -p "$subfolder"
                echo "111111111111111111111 will copy_recursive $file to $subfolder"
                copy_recursive "$file" "$subfolder"
            fi

            # Recursively copy subfolder
            
        elif [ -f "$file" ]; then
            local file_name="$(basename "$file")"
            if array_contains "$file_name" "${exclude_files[@]}"; then
                echo "222222222222222222222 Skipping excluded file: $file_name"
                continue
            else
                echo "222222222222222222222 will cp: $file_name to $destination"
                cp "$file" "$destination"
            fi
        fi
    done
}

copy_recursive "$source_dir" "$destination_dir"
