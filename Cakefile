# Cakefile for building ballinloughdentalcare
# run `cake` to see tasks
task "test", "test the application", ->
  run "node_modules/.bin/mocha"

task "build", "compile the HTML, the CSS and the ECMAScript", ->
  f = (err, files) -> compile(f) for f in files
  require('glob')('*.jade', f)

# CSS compiler
stylus = (str) ->
  require('stylus')(str).use(require('bootstrap-styl')())
# JS compiler
coffee = (str) ->
  require('coffee-script')(str)
# HTML compiler
jade = (str) ->
  require('jade')(str)
  
run = (cmd) ->
  require('child_process').exec cmd, (err, stdout, stderr) ->
    console.error err if err?
    console.log stdout if stdout?
    console.error stderr if stderr
