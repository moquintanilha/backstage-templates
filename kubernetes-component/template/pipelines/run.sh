#!/bin/bash

read -p 'What is your application scope (eg. prod or staging): ' APPLICATION_SCOPE
read -p 'What is Github username: ' GITHUB_USER
read -sp 'What is GitHub Token: ' GITHUB_TOKEN

REGION="us-east-1"
PIPELINE_FILE_PATH="./environments/${APPLICATION_SCOPE}/codepipeline.yml"

aws cloudformation deploy \
--template ${PIPELINE_FILE_PATH} \
--stack-name ${{ values.name }}-${APPLICATION_SCOPE} \
--region ${REGION} \
--parameter-overrides \
GitHubUser=${GITHUB_USER} \
GitHubToken=${GITHUB_TOKEN} \
ApplicationName=${{ values.name }} \
NameSpaceName=${{ values.namespace }} \
ApplicationScope=${APPLICATION_SCOPE} \
--capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM