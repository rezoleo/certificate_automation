#!/usr/bin/env python3

import os

domain = os.environ["CERTBOT_DOMAIN"]
number_remaining_challenges = int(os.environ["CERTBOT_REMAINING_CHALLENGES"])
validation_string = os.environ["CERTBOT_VALIDATION"]
# Only available for HTTP-01 validation
validation_token = os.getenv("CERTBOT_TOKEN")

if validation_token is None:
    # paths to change based on the path of your included file
    directory = "/etc/bind/"
    filename = "rezoleo.letsencrypt"
    with open(directory + filename, "w") as file:
        file.write("_acme-challenge\tIN\tTXT\t" + "cleaned" + "\n")

else:
    directory = "/var/www/html/.well-known/acme-challenge/"
    filename = validation_token
    os.remove(directory + filename)

if number_remaining_challenges == 0:
    print("Challenges cleaned up")
    print("Stopping nginx")
    os.system("systemctl stop nginx.service")
    print("Reloading bind9 DNS configuration")
    os.system("systemctl reload bind9.service")