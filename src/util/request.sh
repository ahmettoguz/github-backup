#!/bin/bash

request() {
    local JQ="../../src/bin/jq.exe"

    if ! command -v "$JQ" &>/dev/null; then
        echo "jq not found at $JQ. Please check the path."
        exit 1
    fi

    local RESPONSE=$(curl -s -H "Authorization: Bearer $githubToken" https://api.github.com/user/repos?per_page=100)

    # Extract repository names, their visibility, and URLs
    REPO_INFO=$(echo "$RESPONSE" | "$JQ" -r '.[] | "\(.name) \(.private) \(.html_url)"')

    # Calculate counts
    totalRepoCount=$(echo "$RESPONSE" | "$JQ" '. | length')
    totalPrivateRepoCount=$(echo "$RESPONSE" | "$JQ" '[.[] | select(.private)] | length')
    totalPublicRepoCount=$(echo "$RESPONSE" | "$JQ" '[.[] | select(.private == false)] | length')
}
