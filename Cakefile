# Simple Cakefile for building ballinloughdentalcare
exec = require('child_process').exec

task "test", "test the application", ->
  run "node_modules/.bin/mocha --compilers coffee:coffee-script/register"

run = (cmd) ->
  exec cmd, (err, stdout, stderr) ->
    console.error err if err?
    console.log stdout if stdout?
    console.error stderr if stderr
