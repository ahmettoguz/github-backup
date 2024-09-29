#!/bin/bash

display_ignore_header() {
    local output=""
    # Loop through each repository name
    for repo in "${ignoredRepositoryNames[@]}"; do
        output+="$repo," # Add the repo name with a comma
    done
    
    # Remove the trailing comma and space
    output="${output%,}"

    echo
    echo "--------------------------- Configurations ---------------------------"
    echo
    echo "Ignored repositories: $output"
    echo
    echo "-----------------------------------------------------------------------"
    echo
}
