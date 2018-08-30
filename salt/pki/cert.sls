/usr/local/share/ca-certificates:
  file.directory

#{% for cert, args in pillar.get('ca',{}).iteritems() %}
#/usr/local/share/ca-certificates/{{ cert }}:
#  x509.pem_managed:
#    - text: {{ salt['mine.get']('salt-master', 'x509.get_pem_entries')['salt-master']['/etc/pki/{{ cert }}']|replace('\n', '') }}
#{% endfor %}
