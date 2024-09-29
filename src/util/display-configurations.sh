#!/bin/bash

display_configurations() {
    local output=""
    # Loop through each repository name
    for repo in "${ignoredRepositoryNames[@]}"; do
        output+="$repo," # Add the repo name with a comma
    done

    # Remove the trailing comma and space
    output="${output%,}"

    echo
    echo "####################################################### Configurations ######################################################"
    echo
    echo "Ignored repositories: $output"
    echo "Total repository count: $totalRepoCount"
    echo "Total private repository count: $totalPrivateRepoCount"
    echo "Total public repository count: $totalPublicRepoCount"
    echo
    echo "#############################################################################################################################"
    echo
}
