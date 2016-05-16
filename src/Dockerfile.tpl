---
dynamic:
  variables: [ $arch, $distro ]
  ref: $arch/$distro/$original_ref
  skip_ext: true
---
# resin.io base image for {{ $distro.name }} {{ $arch.id }}
FROM {{ $arch.id }}/{{ $distro.id }}

{{ include "install" }}

COPY entry.sh /usr/bin/entry.sh
ENTRYPOINT ["/usr/bin/entry.sh"]
