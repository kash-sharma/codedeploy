#!/bin/bash

# Variables
AWS_REGION="ap-south-1"  # Change to your desired AWS region
ECR_REPOSITORY="huedge"  # Your ECR repository name
IMAGE_NAME="kartik-nginx"
IMAGE_TAG="latest"  # You can change this to a version number if desired

# Login to ECR
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin 471112563247.dkr.ecr.$AWS_REGION.amazonaws.com

# Build the Docker image
docker build -t $IMAGE_NAME .

# Tag the image for ECR
docker tag $IMAGE_NAME:latest 47111256327.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY:$IMAGE_TAG

# Push the image to ECR
docker push 471112566327.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY:$IMAGE_TAG

echo "Docker image pushed to ECR: <aws_account_id>.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY:$IMAGE_TAG"

