vault_prereq:
  pkg.installed:
    - pkgs:
      - curl
      - unzip

installing vault to usr/local/bin:
  archive.extracted:
    - name: /usr/local/bin/
    - source: "https://releases.hashicorp.com/vault/0.10.3/vault_0.10.3_linux_amd64.zip"
    - skip_verify: true
    - enforce_toplevel: false

/usr/local/bin/vault:
  file.managed:
    - user: root
    - group: root
    - mode: 766

/etc/vault:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 755

/etc/vault/config.hcl:
  file.managed:
    - source: salt://vault/vault.hcl
    - template: jinja
    - require:
      - file: /etc/vault

/etc/systemd/system/vault.service:
  file.managed:
    - source: salt://vault/vault.service
    - require:
      - file: /etc/vault/config.hcl

vault:
  service.running:
    - enable: True
    - reload: True
    - watch:
      - file: /etc/vault/config.hcl
