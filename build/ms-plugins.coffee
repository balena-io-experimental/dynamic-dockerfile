{ walkFiles } = require('@resin.io/doxx-utils')
HbHelper = require('@resin.io/doxx-handlebars-helper')

{ UNSUPPORTED } = require('../lib/node')

exports.expandProps = walkFiles (file, files) ->
  obj = files[file]
  propsToExpand = obj.expand_props
  return if not propsToExpand
  for prop in propsToExpand
    obj[prop] = HbHelper.render(obj[prop], obj)

exports.dropUnsupported = walkFiles (file, files) ->
  obj = files[file]
  if obj.$arch is UNSUPPORTED
    delete files[file]
