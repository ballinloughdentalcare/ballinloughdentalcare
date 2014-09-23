# Dead simple static website.
#
# Express may even be overkill, but it's there in case we need to extend the
# site to do more than serve pages.

SITE = 'ballinloughdentalcare'

path = require('path')
express = require('express')
basicAuth = require('basic-auth')
redis = require('redis')
fs = require('fs')
marked = require('marked')
util = require('util')
stylus = require('stylus')
nib = require('nib')

# The Express app
app = express()
app.set('port', process.env.PORT or 3000)

# Use Stylus for CSS
css = (str, path) ->
  stylus(str).set('filename', path).set('compress', app.get('env') == 'production').use(nib())
app.use(stylus.middleware(src: 'views', dest: 'public', compile: css))

# Add .html to files that could be served from the public directory
app.use (req, res, next) ->
  return next() if ~req.path.indexOf('.') # extension specified, carry on...
  # no extension - add .html if it would match a static file
  fs.exists path.join(__dirname, 'public', "#{req.path}.html"), (x) ->
    req.path += '.html' if x
    next()

# Serve static files from ./public
app.use express.static(path.join(__dirname, 'public'))

app.set('view engine', 'jade')

# Set up Redis (using Redis To Go) properly
if (process.env.REDISTOGO_URL)
  { port, hostname, auth } = require('url').parse(process.env.REDISTOGO_URL)
  redis = redis.createClient(port, hostname)
  redis.auth(auth.split(':')[1])
else
  redis = redis.createClient()

# Restrict access, if specified.
if process.env.RESTRICTED_ACCESS
  console.log "RESTRICTED ACCESS!"
  [name, pass] = process.env.RESTRICTED_ACCESS.split(':')
  app.use (req, res, next) ->
    credentials = basicAuth(req)
    return next() if credentials?.name == name and credentials?.pass == pass
    res.statusCode = 401
    res.setHeader 'WWW-Authenticate', 'Basic realm="Restricted zone..."'
    res.end 'Unauthorized.'

# Reads the pages into memory
pages = {}
fs.readdir 'views', (err, files) ->
  files.forEach (file) ->
    if file.match /\.md$/
      fs.readFile path.join('views', file), 'utf8', (err, data) ->
        console.error("Error reading markdown: #{err.message}") if err?
        page = file.replace(/\.md/, '.html')
        pages[page] = marked(data)

# Function to render a page from memory - should only be called if the static
# page doesn't exist.
renderPage = (req, res) ->
  page = req.params.page || 'index'
  page += ".html" unless page.match(/\.html$/)
  name = page.split(/\./)[0]
  if html = pages[page]
    res.render(name)
  else
    console.error "404: `#{page}`"
    res.statusCode = 404
    res.render('404')

app.get '/:page', renderPage
app.get '/', renderPage

# Start 'er up!
app.listen(process.env.PORT or 3000)

console.log("...running on port #{app.get('port')}")
