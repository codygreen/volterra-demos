#!/bin/bash
name=$(jq .name -r < volt.p12.json)

# get TF variables
api_token=$(jq '.resources[] < terraform.tfstate | select(.type == "null_resource") | .instances[0].attributes.triggers.api_token' -r)
tenant=$(jq '.resources[] < terraform.tfstate | select(.type == "null_resource") | .instances[0].attributes.triggers.tenant' -r)
credential_name=$(jq '.resources[] < terraform.tfstate | select(.type == "null_resource") | .instances[0].attributes.triggers.credential_name' -r)
p12_file_path=$(jq '.resources[] < terraform.tfstate | select(.type == "null_resource") | .instances[0].attributes.triggers.p12_file_path' -r)

curl --location --request POST "https://${tenant}.console.ves.volterra.io/api/web/namespaces/system/revoke/api_credentials" \
    --header "Authorization: APIToken ${api_token}" \
    --header "Content-Type: application/json" \
    --data-raw "{\"name\": \"${name}\", \"namespace\": \"system\"}"

rm "$credential_name".json
rm "$p12_file_path"/"$credential_name".p12
