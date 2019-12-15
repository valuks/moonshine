config = require('../config').get()
pjson = require('../package.json')
express = require('express')
bodyParser = require('body-parser')
SocketIO = require('socket.io')


app = express()
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: true }))


app.get '/', (req, res) => res.sendFile(__dirname + '/index.html')

data = {}
app.post '/save', (req, res) =>
  append = []
  client = req.body.client
  req.body.sensors.map (sensor)=>
    [client, sensor.id, sensor.t]
  .forEach ([client, sensor, temp])->
    if !data[client]
      data[client] = []
    index = data[client].findIndex (v)-> v.id is sensor
    entry = [temp, new Date(), false]
    if index < 0
      data[client].push {id: sensor, t: [ entry ]}
    else
      entry[2] = data[client][index].t[0][0] isnt entry[0]
      data[client][index].t.splice(0, 0, entry)
      data[client][index].t.splice(60 * 60 * 8)
    append.push {client, id: sensor, entry}
  io.emit 'request', ['append', {append}]
  res.send('ok')

server = app.listen(config.port)


io = SocketIO(server, {
    # serveClient: false
}).on 'connection', (client)->
  client.emit 'request', ['data', data]
  # client.on 'request', (data)->
  # client.on 'disconnect', (reason)->


console.log("http://127.0.0.1:#{config.port}/ version:#{pjson.version}")
