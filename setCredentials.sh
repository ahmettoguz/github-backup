#!/bin/bash

echo "Provide github token:"
read token
# read -s token

echo "TOKEN = '$token'" > credentials.py

echo "Token is saved successfully."
