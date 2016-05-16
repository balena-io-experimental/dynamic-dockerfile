# resin.io base image for Alpine armhf
FROM armhf/alpine

apt-get install -y curl


COPY entry.sh /usr/bin/entry.sh
ENTRYPOINT ["/usr/bin/entry.sh"]
