#!/bin/bash

check_config() {
    if [ -z "$githubToken" ] || [[ "$githubToken" == \<* ]]; then
        echo "Github token is invalid."
        echo "Obtain github token from  https://github.com/settings/tokens"
        echo "Place github token to ./src/config/config.sh"
        exit 1
    fi
}
