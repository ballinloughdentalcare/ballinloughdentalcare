# Dead simple static website.
express = require('express')
http = require('http')
path = require('path')

app = express()

app.set('port', process.env.PORT or 3000)
app.use(express.static(path.join(__dirname, 'public')))
app.listen(process.env.PORT or 3000)
