# Dead simple static website.

SITE = 'ballinloughdentalcare'

path = require('path')
express = require('express')
auth = require('basic-auth')
redis = require('redis')

# The Express app
app = express()
app.set('port', process.env.PORT or 3000)
console.log("...running on port #{app.get('port')}")

# Serve static files from ./public
app.use express.static(path.join(__dirname, 'public'))

# Set up Redis (using Redis To Go) properly
if (process.env.REDISTOGO_URL)
  { port, hostname, auth } = require('url').parse(process.env.REDISTOGO_URL)
  redis = redis.createClient(port, hostname)
  redis.auth(auth.split(':')[1])
else
  redis = redis.createClient()

# Restrict access, if specified.
if process.env.RESTRICTED_ACCESS
  [name, pass] = process.env.RESTRICTED_ACCESS.split(':')
  app.use (req, res, next) ->
    auth = auth(req)
    return next() if auth?.name == name and auth?.pass == pass
    res.statusCode = 401
    res.setHeader 'WWW-Authenticate', 'Basic realm="Restricted zone..."'
    res.end 'Unauthorized.'

app.get /^\/([^.]+)(\.[^.]+)?$/, (req, res) -> res.render(req.params[1])

# Start 'er up!
app.listen(process.env.PORT or 3000)
