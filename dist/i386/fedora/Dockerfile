# resin.io base image for Fedora i386
FROM i386/fedora

yum install curl


COPY entry.sh /usr/bin/entry.sh
ENTRYPOINT ["/usr/bin/entry.sh"]
