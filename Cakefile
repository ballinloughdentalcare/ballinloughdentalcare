npmRun = (cmd) ->
  { exec } = require 'child_process'
  p = exec "node_modules/.bin/#{cmd}"
  p.on 'error', (e) -> console.error e
  p.stdout.on 'data', (s) -> console.log s
  p.stderr.on 'data', (s) -> console.error s

task 'build', "build the website's HTML, JS and CSS", ->
  npmRun 'jade -P {index,about,treatments,fees,contact,thanks}.jade'
  npmRun 'coffee -cm *.coffee'
  npmRun 'stylus -m *.styl'
