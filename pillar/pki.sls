ca:
  outerheaven_root_ca.crt:
        CN: outerheaven Root CA
        C: Uk
        ST: England
        L: London
        emailAddress: "pki-ops@outerheaven.solutions"
        cacert_path: /etc/pki/
        ca_filename: outerheaven_root_ca.crt
        basicConstraints: "critical CA:true"
        keyUsage: "critical cRLSign, keyCertSign"
        subjectKeyIdentifier: hash
        authorityKeyIdentifier: keyid,issuer:always
        days_valid: 3650
        days_remaining: 0
        backup: True
        ca_key: /etc/pki/outerheaven_root_ca.key
        key_bits: 2048
        backup_key: true

intermediate_ca:
  vault_ca_cert.crt:
        CN: outerheaven Vault Int CA
        C: Uk
        ST: England
        L: London
        emailAddress: "pki-ops@outerheaven.solutions"
        signing_policy: "intermidate_ca"
        cacert_path: /etc/pki/
        ca_filename: outerheaven_vault_ca.crt
        basicConstraints: "critical CA:true"
        keyUsage: "critical cRLSign, keyCertSign"
        subjectKeyIdentifier: hash
        authorityKeyIdentifier: keyid,issuer:always
        days_valid: 3650
        days_remaining: 0
        backup: True
        ca_key: /etc/pki/outerheaven_vault_ca.key
        key_bits: 2048
        backup_key: true

web_server_certs:
  vault_server_cert.crt:
        CN: vault.outerheaven
        C: Uk
        ST: England
        L: London
        emailAddress: "pki-ops@outerheaven.solutions"
        signing_policy: "web_server_cert"
        cacert_path: /etc/pki/
        ca_filename: outerheaven-vault-ca.crt
        basicConstraints: "critical CA:false"
        keyUsage: "critical cRLSign, keyCertSign"
        subjectKeyIdentifier: hash
        authorityKeyIdentifier: keyid,issuer:always
        subjectAltName: DNS:vault.int, DNS:labs.outerheaven.solutions, DNS:init-sys.outerheaven.solutions, DNS:consul.int, DNS:influx.int, IP:127.0.0.1, DNS:localhost
        days_valid: 3650
        days_remaining: 0
        backup: True
        ca_key: /etc/pki/outerheaven_vault_server.key
        key_bits: 2048
        backup_key: true

ca_keys:
  /etc/pki/outerheaven_root_ca.key:
        bits: 2048
        backup: true