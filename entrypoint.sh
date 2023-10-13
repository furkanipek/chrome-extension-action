#!/bin/sh

set -e

auth_token_response=`curl \
--silent \
--show-error \
--fail \
-H "Content-Type: application/json" \
-X POST \
-d '{
    "refresh_token": "'$1'",
    "client_id": "'$2'",
    "client_secret": "'$3'",
    "grant_type": "refresh_token",
}' \
-v https://www.googleapis.com/oauth2/v4/token`

if [ $? -ne 0 ]; then
  echo "HTTP request failed."
  exit 1
fi

access_token=$(echo "$auth_token_response" | jq -r '.access_token')

if [ -z "$access_token" ]; then
  echo "The 'access_token' key was not found in the JSON data or is empty."
  exit 1
fi

status=`curl \
--silent \
--show-error \
--fail \
-H "Authorization: Bearer $access_token"  \
-H "x-goog-api-version: 2" \
-X PUT \
-T $4 \
https://www.googleapis.com/upload/chromewebstore/v1.1/items/$5 \
| \
jq -r '.uploadState'`


if [ $status = 'FAILURE' ]
then
  exit 1
fi

if [ $6 = true ] # Publish
then
    if [ "$7" = true ] # Publish Tester
    then
        publishTarget='trustedTesters'
    else
        publishTarget='default'
    fi

    publish=`curl \
    --silent \
    --show-error \
    --fail \
    -H "Authorization: Bearer $access_token"  \
    -H "x-goog-api-version: 2" \
    -H "Content-Length: 0" \
    -X POST \
    -d publishTarget=$publishTarget \
    https://www.googleapis.com/chromewebstore/v1.1/items/$5/publish \
    | \
    jq -r '.publishState'`

  if [ $publish = 'FAILURE' ]
  then
    exit 1
  fi
fi

exit 0
