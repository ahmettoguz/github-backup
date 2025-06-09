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

    local repo_count=$(echo "$json" | jq length)

    for i in $(seq 0 $((repo_count - 1))); do
        local full_name=$(echo "$json" | jq -r ".[$i].full_name")
        local html_url=$(echo "$json" | jq -r ".[$i].clone_url")
        local is_private=$(echo "$json" | jq -r ".[$i].private")
        local owner=$(echo "$full_name" | cut -d'/' -f1)
        local repo_name=$(echo "$full_name" | cut -d'/' -f2)
        local visibility_folder=$([ "$is_private" = true ] && echo "private" || echo "public")

        # Check if repo is in ignore list
        for ignored_repository in "${ignore_list[@]}"; do
            if [[ "$full_name" == "$ignored_repository" ]]; then
                echo "Skipping ignored repository: $full_name"
                continue 2
            fi
        done

        local target_path="backup/$timestamp/$owner/$visibility_folder"

        mkdir -p "$target_path"
        echo "Cloning $full_name"
        git clone --quiet --bare "$html_url" "$target_path/$repo_name"
    done
}

displayPostInfo() {
    echo -e "\033[33m======================================================\033[0m"
    echo -e "\033[32mBackup process completed\033[0m"
    echo -e "\033[33m======================================================\033[0m"
}

check_github_response() {
    local response="$1"

    # bad credentials
    if echo "$response" | jq -e 'type == "object" and has("message") and .message == "Bad credentials"' >/dev/null; then
        echo "GitHub API returned 401 Unauthorized: Bad credentials, check .env configuration."
        exit 1
    fi

    # error check
    if echo "$response" | jq -e 'type == "object" and has("status") and (.status | tonumber) != 200' >/dev/null; then
        local err_msg
        err_msg=$(echo "$response" | jq -r '.message')
        echo "GitHub API returned an error: $err_msg"
        exit 1
    fi
}

displayPreInfo() {
    echo "Analyzing repositories..."
    local github_response_json="$1"
    shift
    local ignore_repository_list=("$@")

    local total_count=$(echo "$github_response_json" | jq length)

    declare -A public_count
    declare -A private_count
    declare -A ignored_repos_map

    for ((i = 0; i < total_count; i++)); do
        local full_name=$(echo "$github_response_json" | jq -r ".[$i].full_name")
        local is_private=$(echo "$github_response_json" | jq -r ".[$i].private")
        local owner=$(echo "$full_name" | cut -d'/' -f1)
        local repo_name=$(echo "$full_name" | cut -d'/' -f2)

        local is_ignored=false
        for ignored in "${ignore_repository_list[@]}"; do
            if [[ "$full_name" == "$ignored" ]]; then
                ignored_repos_map["$owner"]+="$repo_name "
                is_ignored=true
                break
            fi
        done

        if [ "$is_ignored" = false ]; then
            if [ "$is_private" = true ]; then
                private_count["$owner"]=$((${private_count["$owner"]:-0} + 1))
            else
                public_count["$owner"]=$((${public_count["$owner"]:-0} + 1))
            fi
        fi
    done
    echo
    echo -e "\033[33m=============== Repository Information ===============\033[0m"
    echo "Total Repositories: $total_count"
    echo ""

    # get all owners
    owners=()
    for k in "${!public_count[@]}" "${!private_count[@]}" "${!ignored_repos_map[@]}"; do
        owners+=("$k")
    done

    # printf "%s\n" "${owners[@]}"

    # remove duplicates from owners
    owners=($(printf "%s\n" "${owners[@]}" | sort -u))

    for owner in "${owners[@]}"; do
        local pub_count=${public_count[$owner]:-0}
        local priv_count=${private_count[$owner]:-0}
        local ignored_repos=${ignored_repos_map[$owner]:-}

        local ignored_count=0
        if [ -n "$ignored_repos" ]; then
            ignored_count=$(echo "$ignored_repos" | wc -w)
        fi

        local total_owner_count=$((pub_count + priv_count + ignored_count))

        echo "Owner: $owner ($total_owner_count)"
        echo "Public Repositories: $pub_count"
        echo "Private Repositories: $priv_count"
        echo "Ignored Repositories: $ignored_count"
        if [ "$ignored_count" -gt 0 ]; then
            for repo in $ignored_repos; do
                echo " - $repo"
            done
        fi
        echo ""
    done

    echo -e "\033[33m======================================================\033[0m"
    echo
}
