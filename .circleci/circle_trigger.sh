#!/bin/bash

REPOSITORY_TYPE="github"
CIRCLE_API="https://circleci.com/api"

PARAMETERS='"test-project1":true'

DATA="{ \"branch\": \"$CIRCLE_BRANCH\", \"parameters\": { $PARAMETERS } }"
echo "Triggering pipeline with data:"
echo -e "  $DATA"

URL="${CIRCLE_API}/v2/project/${REPOSITORY_TYPE}/${CIRCLE_PROJECT_USERNAME}/${CIRCLE_PROJECT_REPONAME}/pipeline"


echo -e "  $URL"

HTTP_RESPONSE=$(curl --request POST \
  --url https://circleci.com/api/v2/project/gh/fcorange/ngci-test/pipeline \
  --header 'authorization: Basic 4ce8830073aefc635919d62306180dabf5411200' \
  --header 'content-type: application/json' \
  # --header 'x-attribution-actor-id: SOME_STRING_VALUE' \
  # --header 'x-attribution-login: SOME_STRING_VALUE' \
  --data '{"branch":"dev","parameters":{"test-project1":true}}')



# curl -s -u "${CIRCLE_API_USER_TOKEN}:" -o response.txt -w "%{http_code}" -X POST --header "Content-Type: application/json" -d "$DATA" "$URL")

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
