fixArch = require('./arch')

RESIN_URL_PREFIX = 'http://resin-packages.s3.amazonaws.com/node/'
NODEJS_URL_PREFIX = 'http://nodejs.org/dist/'

resinUrl = (arch, nodeVersion) ->
  "#{RESIN_URL_PREFIX}v#{nodeVersion}/node-v#{nodeVersion}-linux-#{arch}.tar.gz"

nodejsUrl = (arch, nodeVersion) ->
  "#{NODEJS_URL_PREFIX}v#{nodeVersion}/node-v#{nodeVersion}-linux-#{arch}.tar.gz"

useOfficialUrl = (arch, distro, nodeVersion) ->
  if distro is 'alpine'
    return false

  if arch in [ 'x86', 'x64' ]
    return true

  if distro is 'debian' and arch in [ 'armv6l', 'armv7l' ]
    return true

  return false

exports.downloadUrl = (arch, distro, nodeVersion) ->
  arch = fixArch(arch, distro, nodeVersion)
  method = if useOfficialUrl(arch, distro, nodeVersion) then nodejsUrl else resinUrl
  return method(arch, nodeVersion)
