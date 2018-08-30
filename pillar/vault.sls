vault:
  address: "0.0.0.0:8200"
  tls_cert_file: "/etc/pki/vault_server_cert.crt"
  tls_key_file: "/etc/pki/outerheaven_vault_server.key"
  tls_client_ca_file: "/etc/vault/vault-server.ca.crt.pem"
  path: "/vault"
  consul_address: "0.0.0.0:8500"