semver = require('semver')

UNSUPPORTED = 'UNSUPPORTED'

ALPINE_ARCH =
  'x64': 'alpine-amd64'
  'x86': 'alpine-i386'
  'armv6hf': 'alpine-armhf'
  'armv7hf': 'alpine-armhf'

module.exports = fixArch = (arch, distro, nodeVersion) ->
  if distro is 'alpine'
    if semver.satisfies(nodeVersion, '0.12.x')
      return UNSUPPORTED
    return ALPINE_ARCH[arch] or UNSUPPORTED

  if distro is 'debian' and semver.gte(nodeVersion, '4.0.0')
    if arch is 'armv7hf'
      return 'armv7l'
    if arch is 'armv6hf'
      return 'armv6l'

  return arch

fixArch.UNSUPPORTED = UNSUPPORTED
