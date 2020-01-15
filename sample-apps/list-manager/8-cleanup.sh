#!/bin/bash
set -eo pipefail
aws cloudformation delete-stack --stack-name list-manager
echo "Deleted list-manager stack."

if [ -f bucket-name.txt ]; then
    ARTIFACT_BUCKET=$(cat bucket-name.txt)
    while true; do
        read -p "Delete deployment artifacts and bucket ($ARTIFACT_BUCKET)?" response
        case $response in
            [Yy]* ) aws s3 rb --force s3://$ARTIFACT_BUCKET; rm bucket-name.txt; break;;
            [Nn]* ) exit;;
            * ) echo "Response must start with y or n.";;
        esac
    done
fi

rm out.yml out.json 4-deploy.sh
rm -rf lib/nodejs/node_modules