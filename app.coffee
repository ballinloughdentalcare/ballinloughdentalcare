express = require 'express'
app = express()
app.use require('morgan')('tiny')
app.use express.static('.')

app.listen process.env.PORT or 3000, ->
  { name, version } = require './package'
  { address, port } = @address()
  console.log "#{name} v#{version} listening on #{address}:#{port}"
