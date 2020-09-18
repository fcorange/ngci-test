#!/bin/bash

CURRENT_COMMIT_HASH=$(git rev-parse HEAD)
CHANGED_FILES=$(git diff-tree --no-commit-id --name-only -r ${CURRENT_COMMIT_HASH})


TEST_PROJECT1=false
TEST_PROJECT2=false

echo "$CHANGED_FILES"

if [[ $CHANGED_FILES == *"project1/"* ]]; then
  TEST_PROJECT1=true
fi

if [[ $CHANGED_FILES == *"project2/"* ]]; then
  TEST_PROJECT2=true
fi

echo "$TEST_PROJECT1"
echo "$TEST_PROJECT2"