#!/bin/bash

# Constants
REPOSITORY_TYPE="github"
CIRCLE_API="https://circleci.com/api"
CIRCLE_TOKEN="ca5b482eba36670b109cfe36cc80c19a1e1a6b92"

# Determine test targets
CURRENT_COMMIT_HASH=$(git rev-parse HEAD)
CHANGED_FILES=$(git diff-tree --no-commit-id --name-only -r ${CURRENT_COMMIT_HASH})

TEST_PROJECT1=false
TEST_PROJECT2=false

echo $TEST_PROJECT1
echo $TEST_PROJECT2

if [[ $CHANGED_FILES == *"project1/"* ]]; then
  TEST_PROJECT1=true
fi

if [[ $CHANGED_FILES == *"project2/"* ]]; then
  TEST_PROJECT2=true
fi

PARAMETERS+=", \"test-project1\":$TEST_PROJECT1"
PARAMETERS+=", \"test-project2\":$TEST_PROJECT2"

echo "$PARAMETERS"

# Assemble POST data
DATA="{ \"branch\": \"$CIRCLE_BRANCH\", \"parameters\": { $PARAMETERS } }"
echo "Triggering pipeline with data:"
echo -e "  $DATA"

URL="${CIRCLE_API}/v2/project/${REPOSITORY_TYPE}/${CIRCLE_PROJECT_USERNAME}/${CIRCLE_PROJECT_REPONAME}/pipeline"

# POST to CircleCI API
HTTP_RESPONSE=$(curl -s -u "${CIRCLE_TOKEN}:" -o response.txt -w "%{http_code}" -X POST --header "Content-Type: application/json" -d "$DATA" "$URL")

if [ "$HTTP_RESPONSE" -ge "200" ] && [ "$HTTP_RESPONSE" -lt "300" ]; then
    echo "API call succeeded."
    echo "Response:"
    cat response.txt
else
    echo -e "\e[93mReceived status code: ${HTTP_RESPONSE}\e[0m"
    echo "Response:"
    cat response.txt
    exit 1
fi