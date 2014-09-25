# Dead simple static website.
#
# Express may even be overkill, but it's there in case we need to extend the
# site to do more than serve pages.
fs              = require 'fs'
url             = require 'url'
express         = require 'express'
morgan          = require 'morgan'
basicAuth       = require 'basic-auth'
jade            = require 'jade'
stylus          = require 'stylus'
nib             = require 'nib'
coffee          = require 'coffee-script'
favicon         = require 'serve-favicon'
join            = require('path').join
bodyParser      = require 'body-parser'
methodOverride  = require 'method-override'

# App creation
app = express()
app.set 'port', process.env.PORT or 3000
app.set 'auth', process.env.RESTRICTED_ACCESS
app.set 'public', join(process.cwd(), 'public')
app.set 'view engine', 'jade'
app.enable 'strict-routing'

# Favicon
app.use favicon(join(app.get('public'), 'favicon.ico'))
# Logger middleware
app.use morgan('combined')

# Authorization middleware
app.use (req, res, next) ->
  return next() unless app.get('auth')
  [name, pass] = app.get('auth').split(':')
  credentials = basicAuth(req)
  return next() if credentials?.name == name and credentials?.pass == pass
  res.status 401
  res.setHeader 'WWW-Authenticate', 'Basic realm="Restricted zone..."'
  res.send 'Unauthorized.'

# Stylus (CSS) middleware
app.use stylus.middleware
  src:      app.get('views')
  dest:     app.get('public')
  force:    app.get('env') isnt 'production'
  compile:  (str, path) ->
    stylus str
      .set 'filename',  path
      .set 'compress',  app.get('env') is 'production'
      .set 'firebug',   app.get('env') isnt 'production'
      .set 'linenos',   app.get('env') isnt 'production'
      .set 'sourcemap', app.get('env') isnt 'production'
      .use nib()

# Coffeescript (JS) middleware
app.use (req, res, next) ->
  force = false#app.get('env') isnt 'production'
  src   = app.get('views')
  dest  = app.get('public')
  return next() unless req.method in ['GET', 'HEAD']
  path = url.parse(req.url).pathname
  return next() unless /\.js$/.test(path)
  jsPath = join dest, path
  coffeePath = join app.get('views'), path.replace(/\.js$/, '.coffee')
  compile = () ->
    fs.readFile coffeePath, 'utf8', (err, str) ->
      return next(err.code is 'ENOENT' ? null : err) if err
      js = coffee.compile str
      fs.writeFile jsPath, js, next
  return compile() if force
  fs.stat coffeePath, (err, coffeeStats) ->
    return next(err) if err?
    fs.stat jsPath, (err, jsStats) ->
      if err?
        return next(err) unless err.code is 'ENOENT'
        return compile()
      return compile() if coffeeStats.mtime > jsStats.mtime
      next()

# Static files from /public
app.use express.static(app.get('public'))

# body-parser and method-override help us handle form submissions
app.use bodyParser()
app.use methodOverride()

# Router
router = express.Router()
router.get '/',           (req, res, next) -> res.render 'index'
router.get '/about',      (req, res, next) -> res.render 'about'
router.get '/contact',    (req, res, next) -> res.render 'contact'
router.get '/fees',       (req, res, next) -> res.render 'fees'
router.get '/treatments', (req, res, next) -> res.render 'treatments'
app.use router

# 404
app.use (req, res, next) ->
  res.status 404
  res.render '404'

# 500
app.use (err, req, res, next) ->
  console.error err.stack
  res.status 500
  res.render '500'

app.listen(app.get('port'))
console.log("...running on port #{app.get('port')}")
