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



echo "Dont get here"


# Go to Grafana, which is symlinked to the custom version.
echo "--- Changing directory to the Grafana go project. ---"
cd $GOPATH/src/github.com/grafana/grafana

git remote add upstream https://github.com/grafana/grafana.git
git fetch -t upstream # 504 issue, internet issues?

# then: (like "git pull" which is fetch + merge)
git merge upstream/$VERSION master

# or, better, replay your local work on top of the fetched branch
# like a "git pull --rebase"
#git rebase upstream/master


