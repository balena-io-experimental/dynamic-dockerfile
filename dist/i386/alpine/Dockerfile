# resin.io base image for Alpine i386
FROM i386/alpine

apt-get install -y curl


COPY entry.sh /usr/bin/entry.sh
ENTRYPOINT ["/usr/bin/entry.sh"]
