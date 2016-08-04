semver = require('semver')
utils = require('./utils')

RESIN_URL_PREFIX = 'http://resin-packages.s3.amazonaws.com/node/'
NODEJS_URL_PREFIX = 'http://nodejs.org/dist/'

UNSUPPORTED = 'UNSUPPORTED'

ALPINE_ARCH =
	'amd64': 'alpine-amd64'
	'i386': 'alpine-i386'
	'armv6hf': 'alpine-armhf'
	'armv7hf': 'alpine-armhf'

resinUrl = (arch, nodeVersion) ->
	"#{RESIN_URL_PREFIX}v#{nodeVersion}/node-v#{nodeVersion}-linux-#{arch}.tar.gz"

nodejsUrl = (arch, nodeVersion) ->
	"#{NODEJS_URL_PREFIX}v#{nodeVersion}/node-v#{nodeVersion}-linux-#{arch}.tar.gz"

binaryName = (arch, nodeVersion) ->
	"node-v#{nodeVersion}-linux-#{arch}.tar.gz"

useOfficialUrl = (arch, distro, nodeVersion) ->
	if distro is 'alpine'
		return false

	if arch in [ 'i386', 'amd64' ]
		return true

	if distro is 'debian' and arch in [ 'armv6l', 'armv7l' ]
		return true

	return false

exports.getNodeArch = (arch, distro, nodeVersion) ->
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

exports.getNodeArch.UNSUPPORTED = UNSUPPORTED

exports.getNodeDownloadUrl = (arch, distro, nodeVersion) ->
	arch = exports.getNodeArch(arch, distro, nodeVersion)
	method = if useOfficialUrl(arch, distro, nodeVersion) then nodejsUrl else resinUrl
	return method(arch, nodeVersion)

exports.getNodeChecksum = (arch, distro, nodeVersion) ->
	arch = exports.getNodeArch(arch, distro, nodeVersion)
	return utils.getChecksum(binaryName(arch, nodeVersion))

exports.getNodeBaseImage = (device, distro, variant, suite = '', version = '') ->
	return utils.generateBaseImage(device, distro, 'node', variant, suite, version)
