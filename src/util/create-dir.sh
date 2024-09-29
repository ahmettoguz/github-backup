#!/bin/bash

create_date_directory() {
    # Get today's date in DD-MM-YYYY format
    local today=$(date +%d-%m-%Y)

    # Create a new directory with today's date
    mkdir "$today"

    # Check if the directory was created successfully
    if [ $? -eq 0 ]; then
        echo "Directory '$today' created successfully."
    else
        echo "Error: Failed to create directory '$today'."
        exit
    fi
}
