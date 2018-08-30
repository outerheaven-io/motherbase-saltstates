nginx_vhosts:
  vault:
    server_name: 'vault.*'
    listen: 443 ssl
    ssl_certificate: /etc/pki/vault_server_cert.crt
    ssl_certificate_key: /etc/pki/outerheaven_vault_server.key
    ssl_client_certificate: /etc/vault/vault-server.ca.crt.pem
    ssl_verify_client: on
    location: /
    proxy_pass:  https://127.0.0.1:8200

  consul:
    server_name: 'consul.*'
    listen: 443 ssl
    ssl_certificate: /etc/pki/vault_server_cert.crt
    ssl_certificate_key: /etc/pki/outerheaven_vault_server.key
    ssl_client_certificate: /etc/vault/vault-server.ca.crt.pem
    ssl_verify_client: on
    location: /
    proxy_pass:  http://127.0.0.1:8500

  gitlab:
    server_name: 'labs.*'
    listen: 443 ssl
    ssl_certificate: /etc/pki/vault_server_cert.crt
    ssl_certificate_key: /etc/pki/outerheaven_vault_server.key
    ssl_client_certificate: /etc/vault/vault-server.ca.crt.pem
    ssl_verify_client: on
    location: /
    proxy_pass:  http://127.0.0.1:8181