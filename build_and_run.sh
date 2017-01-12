#!/bin/bash

# Go to Grafana, which is symlinked to the custom version.
echo "--- Changing directory to the Grafana go project. ---"
cd $GOPATH/src/github.com/grafana/grafana

# Front end build
echo "--- Building the front end. ---"
sudo rm -rf public_gen  # Fix for permission issue. Shouldn't really need.
grunt build
sudo npm install -g yarn
yarn install
sudo npm run build

# Build the application (Go).
echo "--- Building the Go application. ---"
go run build.go setup
go run build.go build

# Run the application.
echo "--- Running the application. ---"
./bin/grafana-server
