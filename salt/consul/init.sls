consul_prereq:
  pkg.installed:
    - pkgs:
      - curl
      - unzip

installing consul to usr/local/bin:
  archive.extracted:
    - name: /usr/local/bin/
    - source: "https://releases.hashicorp.com/consul/1.2.0/consul_1.2.0_linux_amd64.zip"
    - skip_verify: true
    - enforce_toplevel: false

/usr/local/bin/consul:
  file.managed:
    - user: root
    - group: root
    - mode: 766

/etc/consul:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 755

/etc/consul/config.json:
  file.managed:
    - source: salt://consul/consul.config
    - template: jinja
    - require:
      - file: /etc/consul

/etc/systemd/system/consul.service:
  file.managed:
    - source: salt://consul/consul.service
    - require:
      - file: /etc/consul/config.json

consul:
  service.running:
    - enable: True
    - reload: True
    - require:
      - file: /etc/consul/config.json
    - watch:
      - file: /etc/consul/config.json
