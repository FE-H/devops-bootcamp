#!/bin/bash
# Install Docker + docker compose v2 plugin (same approach as terraform3/userdata.sh)
curl -fsSL https://get.docker.com | sh

# Allow the SSM session user to run docker without sudo
id ssm-user &>/dev/null || useradd -m ssm-user
usermod -aG docker ssm-user

# Ensure the docker daemon is up
systemctl enable --now docker

# Deploy Rackula using the official quick-start compose command
mkdir -p /opt/rackula && cd /opt/rackula
curl -fsSL https://raw.githubusercontent.com/RackulaLives/Rackula/main/deploy/docker-compose.persist.yml -o docker-compose.yml
mkdir -p data && chown 1001:1001 data

# Point CORS_ORIGIN at the real public origin so the browser can reach the app/API
PUBLIC_IP=$(curl -fsSL http://checkip.amazonaws.com || true)
export CORS_ORIGIN="http://${PUBLIC_IP:-localhost}:8080"

# Rackula web UI runs on port 8080; API is internal on port 3001
docker compose up -d
