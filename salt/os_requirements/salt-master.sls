install_salt_master:
  cmd.run:
    - name: sh /tmp/install_salt.sh -M git v2018.3.2 >> /var/log/salt-install.log
    - creates:
      - /etc/salt/master

/etc/salt/master:
  file.managed:
    - source: salt://os_requirements/master.jinja
    - template: jinja

{% if pillar['bootstrap'] == True %}
/etc/salt/gcp_creds.json:
  file.managed:
    - source: salt://gcp_creds.json

/etc/salt/id_rsa.pub:
  file.managed:
    - source: salt://os_requirements/id_rsa.pub

/etc/salt/id_rsa:
  file.managed:
    - source: salt://os_requirements/id_rsa
{% endif %}

/etc/salt/master.d:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 755