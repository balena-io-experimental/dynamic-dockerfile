# resin.io base image for Fedora armhf
FROM armhf/fedora

yum install curl


COPY entry.sh /usr/bin/entry.sh
ENTRYPOINT ["/usr/bin/entry.sh"]
