# resin.io base image for Alpine amd64
FROM amd64/alpine

apt-get install -y curl


COPY entry.sh /usr/bin/entry.sh
ENTRYPOINT ["/usr/bin/entry.sh"]
