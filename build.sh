#!/bin/bash

# Variables
AWS_REGION="ap-south-1"  # Change to your desired AWS region
ECR_REPOSITORY="huedge"  # Your ECR repository name
IMAGE_NAME="kartik-nginx"
IMAGE_TAG="latest"  # You can change this to a version number if desired

# AWS Account ID (replace with your actual account ID)
AWS_ACCOUNT_ID="471112563247"

# Login to ECR
echo "Logging in to ECR..."
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

# Build the Docker image with a specific Dockerfile
echo "Building the Docker image..."
docker build -t $IMAGE_NAME -f Dockerfile .

# Check if the image was built successfully
if [[ "$(docker images -q $IMAGE_NAME 2> /dev/null)" == "" ]]; then
    echo "Error: Docker image '$IMAGE_NAME' not found. Build may have failed."
    exit 1
fi

# Tag the image for ECR
echo "Tagging the image..."
docker tag $IMAGE_NAME:latest $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY:$IMAGE_TAG

# Push the image to ECR
echo "Pushing the image to ECR..."
docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY:$IMAGE_TAG

echo "Docker image pushed to ECR: $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY:$IMAGE_TAG"

