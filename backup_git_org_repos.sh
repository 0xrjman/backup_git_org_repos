#!/bin/bash

ORGANIZATION=${1:-"Please provide an organization name as the first argument."}
LIMIT=1000
CLONE_DIR="${ORGANIZATION//-/_}_cloned_repos"

mkdir -p "$CLONE_DIR"
cd "$CLONE_DIR"

if ! gh auth status; then
    echo "Please login to GitHub using gh auth login."
    exit 1
fi

if ! gh repo list "$ORGANIZATION" -L $LIMIT; then
    echo $ORGANIZATION
    echo "Failed to list repositories for [[ $ORGANIZATION. ]]"
    exit 1
fi

gh repo list "$ORGANIZATION" -L $LIMIT | awk '{print $1}' | while read repo; do
    repo_name=$(basename "$repo")
    if [ ! -d "$repo_name" ]; then
        echo "Cloning $repo..."
        if gh repo clone "$repo" -- -q; then
            echo "$repo cloned successfully."
        else
            echo "Failed to clone $repo. Retrying..."
            gh repo clone "$repo" -- -q
        fi
    else
        echo "$repo_name already cloned, skipping."
    fi
done

echo "All repositories cloned."
