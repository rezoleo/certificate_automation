# Automatic TLS renewal

A project to automatically renew TLS certificate using [Let's Encrypt](https://letsencrypt.org/) renewal

This project uses [Certbot](https://certbot.eff.org/) and [Vault](https://www.vaultproject.io/). Certbot create the certificate and Vault propagates the certificate to the servers that need it.

## Renewal part

The renewal part of the code is in the folder renew_and_push. Note that in the folder renew_and_push/certbot_custom_hooks a file "role_id" and "secret_id" created by Vault are needed. To do that you can see the [AppRole](https://developer.hashicorp.com/vault/tutorials/auth-methods/approle) documentation.
To automatize the renewal you can do a Crontab running `certbot renew`. This code should be run on your DNS server. Note that your DNS server should also have a web server running with a text file included (used in python certbot scripts).

## Propagation part

The code for the propagation part is situated in the get_cert/ directory. This code should be run by the command `vault agent -config agent-config.hcl` on the servers that need the TLS certificate. Note that a "role_id" and "secret_id" file are needed on the directory.
