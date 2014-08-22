# Dead simple static website.
http = require('http')
path = require('path')
express = require('express')
marked = require('marked')

# Set up Redis (using Redis To Go) properly
redis = require('redis')
if (process.env.REDISTOGO_URL)
  { port, hostname, auth } = require('url').parse(process.env.REDISTOGO_URL)
  redis = redis.createClient(port, hostname)
  redis.auth(auth.split(':')[1])
else
  redis = redis.createClient()

app = express()

# Restrict access, if specified.
if process.env.RESTRICTED_ACCESS
  [name, pass] = process.env.RESTRICTED_ACCESS.split(':')
  app.use (req, res, next) ->
    auth = require('basic-auth')(req)
    return next() if auth?.name == name and auth?.pass == pass
    res.statusCode = 401
    res.setHeader 'WWW-Authenticate', 'Basic realm="Restricted zone..."'
    res.end 'Unauthorized.'

# Serves static files
app.use express.static(path.join(__dirname, 'public'))

app.set('port', process.env.PORT or 3000)
app.set('view engine', 'jade')

app.get '/', (req, res) -> res.render('index')
app.get '/edit', (req, res) -> res.render('edit')

app.listen(process.env.PORT or 3000)
