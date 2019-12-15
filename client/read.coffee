var request = require('request');
var sensor = require('ds18b20-raspi');

var server = 'http://192.168.1.3:3009';

request.post(server + '/save', {json: {client: 'moonshine', sensors: sensor.readAllC() } }, function () {
   process.exit();
});
