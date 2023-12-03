#!/bin/bash

echo "Provide github token: (https://github.com/settings/tokens)"
read token
# read -s token

echo "TOKEN = '$token'" > credentials.py

echo "Token is saved successfully."
