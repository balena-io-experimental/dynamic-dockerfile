nodeHelper = require('../lib/node')
utils = require('../lib/utils')

module.exports = registerHelpers = (Handlebars) ->
	Handlebars.registerHelper 'getNodeArch', ->
		{ $device: device, $distro: distro, $node_version: nodeVersion } = this
		return nodeHelper.getNodeArch(device.arch, distro.id, nodeVersion.id)

	Handlebars.registerHelper 'getNodeDownloadUrl', ->
		{ $device: device, $distro: distro, $node_version: nodeVersion } = this
		return nodeHelper.getNodeDownloadUrl(device.arch, distro.id, nodeVersion.id)

	Handlebars.registerHelper 'getNodeChecksum', ->
		{ $device: device, $distro: distro, $node_version: nodeVersion } = this
		return nodeHelper.getNodeChecksum(device.arch, distro.id, nodeVersion.id)

	Handlebars.registerHelper 'getNodeBaseImage', ->
		{ $device: device, $distro: distro, $node_version: nodeVersion, $language_variant: variant } = this
		return nodeHelper.getNodeBaseImage(device, distro, variant.id, '' , nodeVersion.id)