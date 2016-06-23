fixArch = require('./arch')

module.exports = registerHelpers = (Handlebars) ->
  Handlebars.registerHelper 'getArch', ->
    { $device: device, $distro: distro, $node_version: nodeVersion } = this
    return fixArch(device.arch, distro.id, nodeVersion.id)
