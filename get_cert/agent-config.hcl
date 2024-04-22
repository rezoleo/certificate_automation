vault {
  address = "https://vault.rezoleo.fr"
  retry {
    num_retries = 5
  }
}

auto_auth {
  method {
    type = "approle"

    config = { 
      // create a role in vault with a policy able to "read" the secret
      role_id_file_path = "role_id" // to change based on the path of the role_id file
      secret_id_file_path = "secret_id" // to change based on the path of the secret_id file
      remove_secret_id_file_after_reading = false
    }
  }

  sinks {
    sink {
      type = "file"

      config = {
        path = "sink-token"
      }
    }
  }
}

template {
  source    = "retrieving_cert.tmpl"
  destination = "/etc/nginx/certificates/template_output" // to change based on the path of the nginx certificates
  perms = "0600"

  exec {
    command = ["systemctl", "reload", "nginx"]
  }
}