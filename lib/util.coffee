Combinatorics = require('js-combinatorics')

compareCombinations = (a, b) ->
  la = a.length
  lb = b.length
  # longer has higher specificity
  if la != lb
    return lb - la
  # later items have lower priority
  # so the combination that skips higher index items has higher specificity
  for i in [0...la]
    if a[i] != b[i]
      return a[i] - b[i]
  return 0

exports.searchOrder = (variables) ->
  count = variables?.length
  return [] if not count

  idx = [0...count]
  combinations = Combinatorics.power(idx)
  .toArray()
  .filter (a) -> !!a.length
  .sort(compareCombinations)

  return combinations.map (c) ->
    c.map (i) -> variables[i]
    .join('+')

exports.walkFiles = (fn) ->
  return (options) ->
    return (files, metalsmith, done) ->
      for file of files
        fn(file, files, metalsmith, options)
      done()
