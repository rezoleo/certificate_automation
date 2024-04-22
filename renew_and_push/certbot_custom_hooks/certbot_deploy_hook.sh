#!/usr/bin/env bash
set -euo pipefail

export PATH="/usr/bin:${PATH}"
CUSTOM_HOOKS_DIR=/root/certbot_custom_hooks # Change this based on the path of your custom hooks directory

VAULT_ADDR="https://vault.rezoleo.fr"
export VAULT_ADDR
ROLE_ID="$(cat ${CUSTOM_HOOKS_DIR}/role_id)"
SECRET_ID="$(cat ${CUSTOM_HOOKS_DIR}/secret_id)"
VAULT_TOKEN="$(vault write -field=token auth/approle/login role_id=${ROLE_ID} secret_id=${SECRET_ID})"
export VAULT_TOKEN

echo "Deploying certificate to Vault secret"
vault kv put -mount=secret certificat-web \
  cert.pem=@[the path you want]/cert.pem \
  chain.pem=@[the path you want]/chain.pem \
  fullchain.pem=@[the path you want]/fullchain.pem \
  privkey.pem=@[the path you want]/privkey.pem