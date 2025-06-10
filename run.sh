#!/bin/bash

set -e

source ./src/function.sh

# request to get repository list
github_response_json=$(get_github_response_json)

# check github response
check_github_response "$github_response_json"

# get ignore repository list from .env into bash array
ignore_repository_list=($(echo "$IGNORE_REPOSITORY_LIST" | jq -r '.[]'))

# display info
displayPreInfo "$github_response_json" "${ignore_repository_list[@]}"

# get timestamp to create unique directory
target_directory=$(get_timestamp)

# get user and ortanigation list
user_and_organization_list=($(get_user_and_organization_list "$github_response_json"))

# create directory structure
create_directory_structure "$target_directory" "${user_and_organization_list[@]}"

# # get clone
clone_repository_list "$github_response_json" "$target_directory" "${ignore_repository_list[@]}"

# display info
displayPostInfo
