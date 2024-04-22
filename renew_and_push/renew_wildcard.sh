#!/bin/bash
set -euo pipefail

export PATH="/usr/bin:${PATH}"

mkdir -p /var/www/html/.well-known/acme-challenge

echo "Updating Certbot..."
/root/certbot/bin/pip install --upgrade certbot > /dev/null

CUSTOM_HOOKS_DIR=/root/certbot_custom_hooks # Change this based on the path of your custom hooks directory

/root/certbot/bin/certbot certonly \
  --cert-name rezoleo.fr \
  --rsa-key-size 4096 \
  --manual \
  --manual-auth-hook ${CUSTOM_HOOKS_DIR}/certbot_auth_hook.py \
  --manual-cleanup-hook ${CUSTOM_HOOKS_DIR}/certbot_cleanup_hook.py \
  --deploy-hook ${CUSTOM_HOOKS_DIR}/certbot_deploy_hook.sh \
  -d *.[domain] \ # Replace [domain] with your domain for dns challenge
  -d [subdomain.domain] # Replace this for HTTP-01 challenge