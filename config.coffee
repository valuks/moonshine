exports.get = (subconfigs = ['local'])->
  c =
    locales: ['en']
    server: 'http://moonshine.sata.lv'
    development: false
    port: 3009
    clients: []
    support:
      email: ''
      pass: ''

  for subconfig in subconfigs
    for key, value of require("./config.#{subconfig}")
      c[key] = if typeof value is 'object' then Object.assign(c[key], value) else value

  return Object.assign c
