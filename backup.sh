#!/bin/bash

source ./src/util/create-dir.sh
source ./src/config/config.sh
source ./src/util/request.sh
source ./src/util/display-configurations.sh
source ./src/util/display-ignore-list.sh
source ./src/util/clone-private.sh
source ./src/util/clone-public.sh
source ./src/util/clone.sh

clear

totalRepoCount=0
totalPrivateRepoCount=0
totalPublicRepoCount=0

create_date_directory
request
display_configurations

if [ -n "$REPO_INFO" ]; then
    for i in {0..3}; do
        if [ "$i" -eq 0 ]; then
            display-ignore-list
        elif [ "$i" -eq 1 ]; then
            clone-private
        elif [ "$i" -eq 2 ]; then
            clone-public
        fi
    done
fi
