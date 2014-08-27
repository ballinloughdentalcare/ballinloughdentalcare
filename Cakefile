# Simple Cakefile for building ballinloughdentalcare
fs = require('fs')
jade = require('jade')
stylus = require('stylus')
nib = require('nib')
marked = require('marked')

PAGES = ['index', 'about', 'location', 'prices']

task 'build', 'Rebuild the website', ->
  html(page) for page in PAGES
  css('style')

task 'clean', 'Remove the HTML files', ->
  fs.unlink("public/#{page}.html") for page in PAGES
  fs.unlink("public/style.css")

layout = jade.compileFile "views/layout.jade", pretty: true

# Compiles a HTML file from markdown using layout.jade
html = (page) ->
  fs.readFile "views/#{page}.md", 'utf8', (err, data) ->
    html = marked(data)
    result = layout(page: page, html: html)
    fs.writeFile "public/#{page}.html", result, (err) ->
      throw err if err

# Compiles the style.css file from style.styl
css = (f) ->
  fs.readFile "views/#{f}.styl", 'utf8', (err, data) ->
    throw err if err
    stylus(data).use(nib()).render (err, css) ->
      fs.writeFile "public/#{f}.css", css, (err) ->
        throw err if err
