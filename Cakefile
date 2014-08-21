fs = require('fs')
jade = require('jade')
less = require('less')

PAGES = ['index', 'about', 'location', 'prices']

task 'build', 'Rebuild the website', ->
  html(page) for page in PAGES
  css('style')

task 'clean', 'Remove the HTML files', ->
  fs.unlink("public/#{page}.html") for page in PAGES
  fs.unlink("public/style.css")

html = (f) ->
  fn = jade.compileFile("views/#{f}.jade")
  fs.writeFile "public/#{f}.html", fn(page: f), (err) -> throw err if err

css = (f) ->
  fs.readFile "views/#{f}.less", {encoding: 'utf8'}, (err, data) ->
    throw err if err
    less.render data, (err, result) ->
      throw err if err
      fs.writeFile "public/#{f}.css", result, (err) -> throw err if err
