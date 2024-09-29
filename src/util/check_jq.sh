#!/bin/bash

check_jq() {
    if ! command -v "$JQ" &>/dev/null; then
        echo "jq not found at $JQ. Please check the path."
        exit 1
    fi
}
