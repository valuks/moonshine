request = require('request')
sensor = require('ds18b20-raspi')

server = 'http://moonshine.sata.lv'

request.post server + '/save', {json: {client: 'moonshine', sensors: sensor.readAllC() } }, =>
  process.exit()
