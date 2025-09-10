#!/bin/bash
set -e

# Login to ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 677276116587.dkr.ecr.us-east-1.amazonaws.com

# Stop old container if running
docker stop myapp || true
docker rm myapp || true

# Run new container
IMAGE_URI=$(cat /home/ec2-user/app/imageDetail.json | jq -r '.ImageURI')
docker run -d --name myapp -p 80:80 $IMAGE_URI
