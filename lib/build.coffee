fs = require('fs')
path = require('path')

_ = require('lodash')
consolidate = require('consolidate')

Metalsmith = require('metalsmith')
dynamic = require('metalsmith-dynamic')
inplace = require('metalsmith-in-place')
HbHelper = require('@resin.io/doxx-handlebars-helper')

rootDir = path.resolve(__dirname, '..')

HbHelper.registerConsolidate(consolidate, importName: 'include')

{ walkFiles, searchOrder} = require('./util')

# TODO: dedupe this and utils with doxx?

dynamicDefaults = walkFiles (file, files) ->
  obj = files[file]
  return if not obj.dynamic
  obj.dynamic.$partials_search ?= searchOrder(obj.dynamic.variables)

metalsmith = Metalsmith(rootDir)
.source('src')
.destination('dist')
.use(dynamicDefaults())
.use(dynamic({
  dictionaries: path.join(rootDir, 'dicts')
  populateFields: [ '$partials_search' ]
}))
.use(inplace({
  engine: 'handlebars'
  partials: 'partials'
}))
.build (err) ->
  if err
    console.error err, err.stack
  else
    console.log('Done')
