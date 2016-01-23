express = require 'express'

app = express()

app.use require('morgan')('tiny')

app.use express.static('.')

app.set 'view engine', 'jade'
app.set 'views', '.'

app.get /^\/(index.html)?$/,    (req, res) -> res.render 'index'
app.get "/about(.html)?",       (req, res) -> res.render 'about'
app.get "/treatments(.html)?",  (req, res) -> res.render 'treatments'
app.get "/fees(.html)?",        (req, res) -> res.render 'fees'
app.get "/contact(.html)?",     (req, res) -> res.render 'contact'
app.get "/thanks(.html)?",      (req, res) -> res.render 'thanks'

app.listen process.env.PORT or 3000, ->
  { name, version } = require './package'
  { address, port } = @address()
  console.log "#{name} v#{version} listening on #{address}:#{port}"
