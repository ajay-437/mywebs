This is a Jenkins freestyle project to 
Create a docker image using docker file use nginx base image and update the display page
(Day 6)Docker file to install nginx and update the display page using ubuntu image with custom port number “mywebs” image
Create a docker hub account copy the docker image to dockerhub then pull the image and execute the same as day 6
Create a jenkins pipeline that will trigger the build when changes are made to docker file  
The build should contain the steps to create a new image in docker hub and and push the code 
BUILD STEPS

#!/bin/bash
set -x
# Build the Docker image with the latest tag
docker build -t ajay437/mywebs:latest .

# Get the latest version of the image
CURRENT_VERSION=$(docker images --format "{{.Tag}}" ajay437/mywebs | grep -E '^[0-9]+\.[0-9]+$' | sort -r | head -n 1)

# If there's no version yet, start with 0.1
if [ -z "$CURRENT_VERSION" ]; then
    NEW_VERSION="0.1"
else
    # Extract the major and minor parts of the current version
    IFS='.' read -r -a VERSION_PARTS <<< "$CURRENT_VERSION"
    
    MAJOR="${VERSION_PARTS[0]}"
    MINOR="${VERSION_PARTS[1]}"

    # Increment the minor version
    MINOR=$((MINOR + 1))

    # Combine back into a new version
    NEW_VERSION="$MAJOR.$MINOR"
fi

# Tag the Docker image with the new version
docker tag ajay437/mywebs:latest ajay437/mywebs:$NEW_VERSION

# Output the new version
echo "New version tagged: ajay437/mywebs:$NEW_VERSION"

# Log in to Docker Hub
docker login -u user -p ACCESS_KEY

# Push both the latest and new version tags
docker push ajay437/mywebs:latest
docker push ajay437/mywebs:$NEW_VERSION

