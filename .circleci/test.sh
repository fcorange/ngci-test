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

PARAMETERS='"trigger-workflows":false, "test-project1":"$TEST_PROJECT1", "test-project2":${TEST_PROJECT2}'
echo "$PARAMETERS"



PARAMS='"trigger":false'

PARAMS+=", \"test-project1\":$TEST_PROJECT1"

echo "$PARAMS"