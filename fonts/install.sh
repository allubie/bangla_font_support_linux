#!/bin/bash

# Directory of the script file
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Define the source directory containing the .ttf files
source_dir="$script_dir/ttf"

# Check for any .ttf files in the source directory
if [ -z "$(ls -A "$source_dir"/*.ttf 2>/dev/null)" ]; then
    echo "No .ttf files found in the source directory: $source_dir"
    exit 1
fi

# Prompt the user to select an install option
echo "Select an install option:"
echo "1) Single user"
echo "2) System-wide"
read -p "Enter your choice [1 or 2]: " choice

# Define the destination directories
single_user_dir="$HOME/.local/share/fonts"
system_wide_dir="/usr/share/fonts/ttf"

# Function to copy .ttf files
copy_files() {
    local dest_dir=$1
    mkdir -p "$dest_dir"
    cp "$source_dir"/*.ttf "$dest_dir"
    echo "Fonts copied to $dest_dir"
}

# Perform the copy based on the user's choice
case $choice in
    1)
        copy_files "$single_user_dir"
        ;;
    2)
        if [ "$EUID" -ne 0 ]; then
            echo "Please run as root to install system-wide."
            exit 1
        fi
        copy_files "$system_wide_dir"
        ;;
    *)
        echo "Invalid choice. Please run the script again and select 1 or 2."
        exit 1
        ;;
esac

# Update the font cache
fc-cache -f -v

echo "
▗▄▄▄  ▗▄▖ ▗▖  ▗▖▗▄▄▄▖
▐▌  █▐▌ ▐▌▐▛▚▖▐▌▐▌   
▐▌  █▐▌ ▐▌▐▌ ▝▜▌▐▛▀▀▘
▐▙▄▄▀▝▚▄▞▘▐▌  ▐▌▐▙▄▄▖
                     "
