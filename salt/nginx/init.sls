install_nginx:
  pkg.installed:
    - pkgs:
      - nginx

/etc/nginx/sites-available/default:
  file.managed:
    - source: salt://nginx/nginx.default
    - template: jinja

nginx:
  service.running:
    - enable: True
    - reload: True
    - watch:
      - file: /etc/nginx/sites-available/default
      - x509: /etc/pki/vault_server_cert.crt