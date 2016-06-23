---
dynamic:
  variables: [ $device, $distro, $node_version ]
  ref: $device/$distro/$node_version/$original_ref
  skip_ext: true
expand_props: [ $arch ]
$arch: '{{ getArch }}'
---
# autogenerated file
# resin.io base image for {{ $device.name }}, {{ $distro.name }}, node v{{ $node_version.id }}
FROM {{ $arch }}/{{ $distro.id }}

{{ include "install" }}

COPY entry.sh /usr/bin/entry.sh
ENTRYPOINT ["/usr/bin/entry.sh"]
