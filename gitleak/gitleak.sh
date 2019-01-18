#!/bin/bash
set -e
set -o pipefail

if [[ ! -z "$TOKEN" ]]; then
	GITHUB_TOKEN=$TOKEN
fi

if [[ -z "$GITHUB_TOKEN" ]]; then
	echo "Set the GITHUB_TOKEN env variable."
	exit 1
fi

GH_API=https://api.github.com
GH_API_VERSION=v3
GH_API_ACCEPT_HEADER="Accept: application/vnd.github.${GH_API_VERSION}+json"
GH_API_AUTH_HEADER="Authorization: token ${GITHUB_TOKEN}"

main() {
    action=$(jq --raw-output .action "$GITHUB_EVENT_PATH")
    state=$(jq --raw-output .pull_request.state "$GITHUB_EVENT_PATH")

    echo "Action: $action State: $state"
    
    if [[ "$action" == "submitted"]] && [[ "$state" == "open" ]]; then
        owner=$(jq --raw-output .pull_request.head.repo.owner.login "$GITHUB_EVENT_PATH")
		echo "Owner: $owner"
        
        repo=$(jq --raw-output .pull_request.head.repo.name "$GITHUB_EVENT_PATH")
        echo "Repository: $repo"
        
        sender=$(jq --raw-output .sender.login "$GITHUB_EVENT_PATH")
        echo "Sender: $sender"
        
        pr=$(jq --raw-output .pull_request.number "$GITHUB_EVENT_PATH")
        echo "Pull Request Number: $pr" 
        
        #get all commit files
        echo "Getting files from commits associated with this PR"

        #scan files to see sensitive information is checked information
        echo "Scanning files in commits for secrets"

        #create an issue for sender
        echo "Secrets found, creating an issue for sender $sender"


    fi
}


main "$@"
