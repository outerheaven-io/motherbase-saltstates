salt-master:
  service.running:
    - enable: True
    - listen:
      - file: /etc/salt/minion.d/signing_policies.conf

/etc/salt/minion.d/signing_policies.conf:
  file.managed:
    - source: salt://signing_policies.conf

/etc/pki:
  file.directory:
    - require:
      - file: /etc/salt/minion.d/signing_policies.conf

/etc/pki/issued_certs:
  file.directory:
    - require:
      - file: /etc/pki

{% for ca_key, args in pillar.get('ca_keys',{}).iteritems()%}
{{ ca_key }}:
  x509.private_key_managed:
    - bits: {{ args['bits'] }}
    - backup: {{ args['backup'] }}
    - require:
      - file: /etc/pki
{% endfor %}

{% for cert, args in pillar.get('ca',{}).iteritems() %}
/etc/pki/{{ cert }}:
  x509.certificate_managed:
    - signing_private_key: {{ args['ca_key'] }}
    - CN: {{ args['CN'] }}
    - C: {{ args['C'] }}
    - ST: {{ args['ST'] }}
    - L: {{ args['L'] }}
    - basicConstraints: {{ args['basicConstraints'] }}
    - keyUsage: {{ args['keyUsage'] }}
    - subjectKeyIdentifier: {{ args['subjectKeyIdentifier'] }}
    - authorityKeyIdentifier: {{ args['authorityKeyIdentifier'] }}
    - days_valid: {{ args['days_valid'] }}
    - days_remaining: {{ args['days_remaining'] }}
    - backup: {{ args['backup'] }}
    - require:
      - file: /etc/pki
      - x509: {{ args['ca_key'] }}

mine.ca_send:
  module.run:
    - func: x509.get_pem_entries
    - kwargs:
        glob_path: /etc/pki/{{ cert }}
    - require:
      - file: /etc/pki
      - x509: /etc/pki/{{ cert }}
    - onchanges:
      - x509: /etc/pki/{{ cert }}
{% endfor %}

{% for cert, args in pillar.get('intermediate_ca', {}).iteritems() %}
/etc/pki/{{ cert }}:
  x509.certificate_managed:
    - CN: {{ args['CN'] }}
    - C: {{ args['C'] }}
    - ST: {{ args['ST'] }}
    - L: {{ args['L'] }}
    - basicConstraints: {{ args['basicConstraints'] }}
    - signing_policy: {{ args['signing_policy'] }}
    - keyUsage: {{ args['keyUsage'] }}
    - subjectKeyIdentifier: {{ args['subjectKeyIdentifier'] }}
    - authorityKeyIdentifier: {{ args['authorityKeyIdentifier'] }}
    - days_valid: {{ args['days_valid'] }}
    - days_remaining: {{ args['days_remaining'] }}
    - backup: {{ args['backup'] }}
    - managed_private_key:
        name: {{ args['ca_key'] }}
        bits: {{ args['key_bits'] }}
        backup: {{ args['backup_key'] }}

mine.inter_send:
  module.run:
    - func: x509.get_pem_entries
    - kwargs:
        glob_path: /etc/pki/{{ cert }}
    - require:
      - file: /etc/pki
      - x509: /etc/pki/{{ cert }}
    - onchanges:
      - x509: /etc/pki/{{ cert }}
{% endfor %}


{% for cert, args in pillar.get('web_server_certs',{}).iteritems() %}
/etc/pki/{{ cert }}:
  x509.certificate_managed:
    - CN: {{ args['CN'] }}
    - C: {{ args['C'] }}
    - ST: {{ args['ST'] }}
    - L: {{ args['L'] }}
    - basicConstraints: {{ args['basicConstraints'] }}
    - signing_policy: {{ args['signing_policy'] }}
    - keyUsage: {{ args['keyUsage'] }}
    - subjectKeyIdentifier: {{ args['subjectKeyIdentifier'] }}
    - authorityKeyIdentifier: {{ args['authorityKeyIdentifier'] }}
    - subjectAltName: {{ args['subjectAltName'] }}
    - days_valid: {{ args['days_valid'] }}
    - days_remaining: {{ args['days_remaining'] }}
    - backup: {{ args['backup'] }}
    - managed_private_key:
        name: {{ args['ca_key'] }}
        bits: {{ args['key_bits'] }}
        backup: {{ args['backup_key'] }}
{% endfor %}
