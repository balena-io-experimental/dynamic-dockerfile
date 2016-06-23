fixArch = require('../lib/arch')
{ downloadUrl: nodeDownloadUrl } = require('../lib/node')

module.exports = registerHelpers = (Handlebars) ->
  Handlebars.registerHelper 'getArch', ->
    { $device: device, $distro: distro, $node_version: nodeVersion } = this
    return fixArch(device.arch, distro.id, nodeVersion.id)

  Handlebars.registerHelper 'nodeDownloadUrl', ->
    { $device: device, $distro: distro, $node_version: nodeVersion } = this
    return nodeDownloadUrl(device.arch, distro.id, nodeVersion.id)
