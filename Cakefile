task 'build', 'build the website', ->
  { writeFile } = require 'fs'
  { compileFile } = require 'pug'
  { basename, extname } = require 'path'
  glob = require 'glob'
  glob '*.pug', (err, files) ->
    files.forEach (f) ->
      o = "#{basename(f)}.html"
      c = compileFile(f)
      writeFile(o, c(), 'utf8', -> console.log("#{f} → #{o} ✓"))

task 'test', 'run tests', ->
  run 'node_modules/.bin/mocha'

task 'clean', 'remove the compiled HTML files', ->
  run 'rm -fv *.html'

run = (cmd) ->
  {log, error} = console
  require('child_process').exec cmd, (err, stdout, stderr) ->
    throw(err)    if err?
    log(stdout)   if stdout?
    error(stderr) if stderr?

