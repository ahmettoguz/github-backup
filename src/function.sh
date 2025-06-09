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
    shift 2
    local ignore_list=("$@")
        local repo_name=$(basename "$full_name")
        for ignored_repository in "${ignore_list[@]}"; do
            if [[ "$full_name" == "$ignored_repository" ]]; then
                echo "Skipping ignored repository: $full_name"
                continue 2
            fi
        done

        local target_path="backup/$timestamp/$owner/$visibility_folder"
        echo "Cloning $full_name"
        git clone --quiet --bare "$html_url" "$target_path/$repo_name"
    done
}