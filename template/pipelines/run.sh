#!/bin/bash

read -p 'What is application name: ' APPNAME
read -p 'What is your application scope (eg. prod or staging): ' APPLICATION_SCOPE
read -p 'What is Github username: ' GITHUB_USER
read -sp 'What is GitHub Token: ' GITHUB_TOKEN

REGION="us-east-1"
K8S_NAMESPACE=${{ values.name }}
PIPELINE_FILE_PATH="./environments/${APPLICATION_SCOPE}/codepipeline.yml"

aws cloudformation deploy \
--template ${PIPELINE_FILE_PATH} \
--stack-name ${APPNAME}-${APPLICATION_SCOPE} \
--region ${REGION} \
--parameter-overrides \
GitHubUser=${GITHUB_USER} \
GitHubToken=${GITHUB_TOKEN} \
ApplicationName=${APPNAME} \
NameSpaceName=${K8S_NAMESPACE} \
ApplicationScope=${APPLICATION_SCOPE} \
--capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM