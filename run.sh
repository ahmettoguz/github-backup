#!/bin/bash

source .env
source ./src/function.sh

# request to get repository list
github_response_json=$(get_github_response_json)

# get timestamp to create unique directory
target_directory=$(get_timestamp)

# get user and ortanigation list
user_and_organization_list=($(get_user_and_organization_list "$github_response_json"))

# create directory structure
create_directory_structure "$target_directory" "${user_and_organization_list[@]}"

# get ignore repository list from .env into bash array
ignore_repository_list=($(echo "$IGNORE_REPOSITORY_LIST" | jq -r '.[]'))

# get clone
clone_repository_list "$github_response_json" "$target_directory" "${ignore_repository_list[@]}"
