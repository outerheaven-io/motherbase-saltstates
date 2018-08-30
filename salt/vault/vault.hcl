ui = true

listener "tcp" {
  address = "{{ pillar['vault']['address'] }}"
  tls_cert_file = "{{ pillar['vault']['tls_cert_file'] }}"
  tls_key_file = "{{ pillar['vault']['tls_key_file'] }}"
  tls_client_ca_file = "{{ pillar['vault']['tls_client_ca_file'] }}"
}


storage "consul" {
  address = "{{ pillar['vault']['consul_address'] }}"
  path    = "{{ pillar['vault']['path'] }}"
}

#storage "gcs" {
#  bucket           = "${storage_bucket}"
#  credentials_file = "/etc/vault/gcp_credentials.json"
#}