#!/bin/bash

clone-public() {
    cd "./public"
    echo
    echo
    echo
    echo "################################################### Public Repositories ####################################################"
    echo
    while IFS= read -r line; do
        # Extract values from the line
        repo_name=$(echo "$line" | awk '{print $1}')
        is_private=$(echo "$line" | awk '{print $2}')
        repo_url=$(echo "$line" | awk '{print $3}')

        if [[ ! " ${ignoredRepositoryNames[@]} " =~ " $repo_name " ]]; then
            if [ "$is_private" == "false" ]; then
                printf "%s %s : %s\n" "-------------------------------------------------------------------------> " "$repo_name" "$repo_url"
                git clone --mirror "$repo_url"
                echo "-------------------------------------------------------------------------"
                echo
            fi
        fi

    done <<<"$REPO_INFO"
    echo
    echo "#############################################################################################################################"
}
