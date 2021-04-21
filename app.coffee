# Runs a server, which renders jade, and serves static files.
express = require 'express'

app = express()

auth = (req, res, next) ->
  credentials = require('basic-auth')(req)
  { name, pass } = credentials if credentials?
  return next() if "#{name}:#{pass}" is process.env.RESTRICTED_ACCESS
  res.statusCode = 401
  res.setHeader 'WWW-Authenticate', 'Basic realm="Ballinlough Dental Care"'
  res.render '401'

app.use require('morgan')('tiny')

app.use(auth) if process.env.RESTRICTED_ACCESS

app.use express.static('.')

app.set 'view engine', 'pug'
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
