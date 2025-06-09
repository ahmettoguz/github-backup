#!/bin/bash

get_github_response_json() {
    curl -s -H "Authorization: Bearer $GITHUB_TOKEN" https://api.github.com/user/repos?per_page=100
}

get_user_and_organization_list() {
    local json="$1"
    echo $(echo "$json" | jq -r '.[].full_name | split("/") | .[0]' | sort -u)
}

create_directory_structure() {
    local timestamp="$1"
    shift # remove timestamp from args, now $@ is subfolders array

    for folder in "$@"; do
        mkdir -p "backup/$timestamp/$folder/"{private,public}
    done
}

get_timestamp() {
    date +"%Y-%m-%d-%H-%M-%S"
}

clone_repository_list() {
    local json="$1"
    local timestamp="$2"

    echo "$json" | jq -c '.[]' | while read -r repo; do
        local full_name=$(echo "$repo" | jq -r '.full_name')
        local html_url=$(echo "$repo" | jq -r '.html_url')
        local is_private=$(echo "$repo" | jq -r '.private')
        local owner=$(echo "$full_name" | cut -d'/' -f1)
        local visibility_folder=$([[ "$is_private" == "true" ]] && echo "private" || echo "public")

        local target_path="backup/$timestamp/$owner/$visibility_folder"

        echo "Cloning $html_url into $target_path"
        git clone --quiet  --bare "$html_url" "$target_path/$(basename "$full_name")"
    done
}
