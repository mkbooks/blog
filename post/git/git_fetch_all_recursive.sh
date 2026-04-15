#!/bin/bash

function git_fetch_recursive() {
  for dir in "$1"/*; do
    if [ -d "$dir" ]; then
      if [ -d "$dir/.git" ]; then
        echo "Fetching all in $dir"
        cd "$dir"
        git pull --rebase
        git fetch --all --tags
        cd - > /dev/null
      else
        git_fetch_recursive "$dir"
      fi
    fi
  done
}

git_fetch_recursive .
