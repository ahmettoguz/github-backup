#!/bin/bash

request() {
    local RESPONSE=$(curl -s -H "Authorization: Bearer $githubToken" https://api.github.com/user/repos?per_page=100)

    # Extract repository names, their visibility, and URLs
    REPO_INFO=$(echo "$RESPONSE" | "$JQ" -r '.[] | "\(.name) \(.private) \(.html_url)"')
}
