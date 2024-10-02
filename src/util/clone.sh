#!/bin/bash

clone() {
    if [ -n "$REPO_INFO" ]; then
        for i in {0..3}; do
            if [ "$i" -eq 0 ]; then
                display-ignore-list
            elif [ "$i" -eq 1 ]; then
                clone-public
            elif [ "$i" -eq 2 ]; then
                clone-private
            fi
        done
    fi
}
