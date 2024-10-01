#!/bin/bash

display-ignore-list() {
    echo
    echo
    echo "################################################### Ignored Repositories ####################################################"
    echo
    while IFS= read -r line; do
        # Extract values from the line
        repo_name=$(echo "$line" | awk '{print $1}')
        is_private=$(echo "$line" | awk '{print $2}')
        repo_url=$(echo "$line" | awk '{print $3}')

        if [[ " ${ignoredRepositoryNames[@]} " =~ " $repo_name " ]]; then
            echo "$repo_name : $repo_url"
        fi
    done <<<"$REPO_INFO"
    echo
    echo "#############################################################################################################################"
}
