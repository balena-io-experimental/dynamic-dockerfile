{ walkFiles } = require('@resin.io/doxx-utils')
HbHelper = require('@resin.io/doxx-handlebars-helper')

exports.expandProps = walkFiles (file, files) ->
  obj = files[file]
  propsToExpand = obj.expand_props
  return if not propsToExpand
  for prop in propsToExpand
    obj[prop] = HbHelper.render(obj[prop], obj)
