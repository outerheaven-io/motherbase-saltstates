bootstrap: True

pkgs:
   - curl
   - unzip
   - vim
   - zsh
   - python-pip
   - gnupg2
   - docker.io
   - python-pygit2

pip-pkgs:
   - docker-py
   - influxdb
   - python-gnupg
   - psycopg2
   - python-consul

salt_config:
    vaulturl: https://127.0.0.1:8200
    vaultauthmethod: token
    vaulttoken: 2872fef8-4895-30b3-3e38-9064b59c898c
    consulhost: 127.0.0.1
    consulport: 8500
    consultoken: 65d4b5a0-479e-4557-bff1-e5607d582e67
    consulscheme: http
    consulconsistency: default
    consuldc: vagrant-cloud
    consulverify: True
    pghost: 'localhost'
    pguser: 'salt'
    pgpassword: 'salt'
    pgdb: 'salt'
    pgport: 5432
