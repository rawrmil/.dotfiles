#!/bin/bash

if [ -z "$1" ]; then
    echo "No branch name supplied"
	exit 1
fi

git checkout -b $1
git commit --allow-empty -m "Initial commit"
git push -u origin $1
