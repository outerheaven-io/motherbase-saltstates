{% for pkg in pillar.get('pkgs', []) %}
{{ pkg }}:
  pkg.installed
{% endfor %}

{% for pkg in pillar.get('pip-pkgs', []) %}
{{ pkg }}:
  pip.installed:
    - require:
      - pkg: python-pip
{% endfor %}

/srv/gitlab/config/:
  file.directory:
    - user: root
    - group: root
    - makedirs: True
    - dir_mode: 755

/srv/postgres/saltstack_database.sql:
  file.managed:
    - source: salt://os_requirements/saltstack_database.sql
    - makedirs: True

required_postgres_server:
  docker_container.running:
    - name: postgres_server
    - image: postgres:10.4-alpine
    - binds: /srv/postgres:/var/lib/
    - environment:
      - POSTGRES_USER: salt
      - POSTGRES_PASSWORD: salt
    - port_bindings:
      - 5432:5432

provison_database:
  module.run:
    - name: docker.run
    - m_name: postgres_server
    - cmd: 'psql -U salt -d salt -a -f /var/lib/saltstack_database.sql && touch /var/lib/provisioned'
    - require:
      - docker_container: required_postgres_server

include:
  - .salt-master
