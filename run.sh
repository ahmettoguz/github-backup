#!/bin/bash

source .env
source ./src/function.sh

# request to get repository list
# github_response_json=$(get_github_response_json)

github_response_json='[
  {"full_name": "ahmettoguz/git-repo-backup", "html_url": "https://github.com/ahmettoguz/git-repo-backup", "private": false},
  {"full_name": "ahmettoguz/Minesweeper", "html_url": "https://github.com/ahmettoguz/Minesweeper", "private": false}
]'

# get timestamp to create unique directory
target_directory=$(get_timestamp)

# get user and ortanigation list
user_and_organization_list=($(get_user_and_organization_list "$github_response_json"))

# create directory structure
create_directory_structure "$target_directory" "${user_and_organization_list[@]}"

# get clone
clone_repository_list "$github_response_json" "$target_directory"


