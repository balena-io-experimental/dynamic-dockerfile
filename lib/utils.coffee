grep  = require('grepit')
fs = require('fs')

CHECKSUM_FILE_PATH = 'SHASUMS256.txt'
UNSUPPORTED = 'UNSUPPORTED'

ALPINE_ARCH =
	'amd64': 'amd64'
	'i386': 'i386'
	'armv6hf': 'armhf'
	'armv7hf': 'armhf'

FEDORA_ARCH = 
	'armv7hf': 'armv7hf'

BUILDPACK_TEMPLATE = 


resolveArch = (arch, distro) ->
	if distro is 'alpine'
		return ALPINE_ARCH[arch] or UNSUPPORTED
	if distro is 'fedora'
		return FEDORA_ARCH[arch] or UNSUPPORTED
	return arch

exports.getChecksum = (filename) ->
	result = grep(filename, CHECKSUM_FILE_PATH)
	if result.length > 0
		return result[0].replace(/^\s+|\s+$/g, '');
	else
		return null

exports.generateBaseImage = (device, distro, type, variant, suite = '', version = '') ->
	arch = resolveArch(device.arch, distro.id)
	if distro.id is 'debian'
		base = device.id
	else
		base = "#{device.id}-#{distro.id}"

	if type is 'arch'
		return "resin/#{arch}-#{distro.id}:#{suite}"
	if type is 'device'
		return "resin/#{device.id}-#{distro.id}:#{suite}"

	if type is 'buildpack'
		if variant is 'curl'
			return "resin/#{device.id}-#{distro.id}:#{suite}"
		if variant is 'scm'
			return "resin/#{base}-buildpack-deps:#{suite}-curl"
		if variant is 'default'
			return "resin/#{base}-buildpack-deps:#{suite}-scm"

	# Only language specific types left
	if variant is 'default'
		return "resin/#{base}-buildpack-deps:latest"
	if variant is 'slim'
		return "resin/#{device.id}-#{distro.id}:latest"
	if variant is 'onbuild'
		return "resin/#{base}-#{type}:#{version}"
	if variant is 'old_suite'
		return "resin/#{base}-buildpack-deps:#{distro.suite[1]}"




			
