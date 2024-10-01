#!/bin/bash

create_backup_dir() {
    mkdir -p "backup"
}
create_date_directory() {
    # Get today's date in DD-MM-YYYY format
    today=$(date +%d-%m-%Y)

    if ! mkdir "./backup/$today" 2>/dev/null; then
        echo "Failed to create backup directory './backup/$today'."
        echo "This backup has already been taken."
        exit 1
    fi

    cd "./backup/$today"
    mkdir "private"
    mkdir "public"
}
