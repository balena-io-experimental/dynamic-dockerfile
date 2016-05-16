fs = require('fs')
path = require('path')

_ = require('lodash')
consolidate = require('consolidate')

Metalsmith = require('metalsmith')
dynamic = require('metalsmith-dynamic')
inplace = require('metalsmith-in-place')
HbHelper = require('@resin.io/doxx-handlebars-helper')
{ defaultPartialsSearch } = require('@resin.io/doxx-utils')

rootDir = path.resolve(__dirname, '..')

HbHelper.registerConsolidate(consolidate, importName: 'include')

metalsmith = Metalsmith(rootDir)
.source('src')
.destination('dist')
.use(defaultPartialsSearch())
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
