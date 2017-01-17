#!/bin/bash

# Loop and prepare options.
while getopts v: option
do
  case "${option}"
  in
     v) VERSION=${OPTARG};;
  esac
done

# Check for version.
if [ -z "$VERSION" ]
then
  echo "Error: You must specify a version."
fi

# Go to Grafana, which is symlinked to the custom version.
echo "--- Changing directory to the Grafana go project. ---"
cd $GOPATH/src/github.com/grafana/grafana

# Checkout the branch we're merging updates into.
git checkout master

# Set (opposed to add) the origin url. Add will error, if it already exists.
git remote set-url upstream https://github.com/grafana/grafana.git

# Fetch tags from upstream
git fetch upstream
git fetch --tags upstream



# then: (like "git pull" which is fetch + merge)
git rebase $(git rev-parse $VERSION) master

# or, better, replay your local work on top of the fetched branch
# like a "git pull --rebase"
#git rebase upstream/master


