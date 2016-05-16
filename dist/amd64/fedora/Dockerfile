# resin.io base image for Fedora amd64
FROM amd64/fedora

yum install curl


COPY entry.sh /usr/bin/entry.sh
ENTRYPOINT ["/usr/bin/entry.sh"]
