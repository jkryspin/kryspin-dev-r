#!/bin/bash

# Deployment script for kryspin-dev-r application
# This script copies files to the remote server and restarts the service

set -e  # Exit on any error

# Configuration
REMOTE_USER="jkryspin"
REMOTE_HOST="pop-os.local"
REMOTE_PATH="/home/jkryspin/kryspin-dev-r"
SERVICE_NAME="kryspin-dev-r.service"

echo "🚀 Starting deployment to ${REMOTE_USER}@${REMOTE_HOST}..."

# Step 1: Copy files to remote server
echo "📁 Copying files to remote server..."
rsync -avz --progress --delete \
  --exclude '.git/' \
  --exclude 'node_modules/' \
  --exclude '.DS_Store' \
  ./ ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_PATH}/

# Step 2: Install dependencies on remote server
echo "📦 Installing dependencies on remote server..."
ssh ${REMOTE_USER}@${REMOTE_HOST} "cd ${REMOTE_PATH} && npm install --production"

# Step 3: Restart service
echo "🔄 Restarting service..."
ssh ${REMOTE_USER}@${REMOTE_HOST} "sudo systemctl restart ${SERVICE_NAME}"

# Step 4: Check service status
echo "✅ Checking service status..."
ssh ${REMOTE_USER}@${REMOTE_HOST} "sudo systemctl status ${SERVICE_NAME} --no-pager"

echo "🎉 Deployment completed successfully!"
echo "Service is running at: http://${REMOTE_HOST}:3000"