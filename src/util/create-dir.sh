#!/bin/bash

create_date_directory() {
    # Get today's date in DD-MM-YYYY format
    today=$(date +%d-%m-%Y)

    if ! mkdir "$today"; then
        echo "Error: Failed to create directory '$today'."
        exit
    fi

    cd "./$today"
    mkdir "private"
    mkdir "public"
}
