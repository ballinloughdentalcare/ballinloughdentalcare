task 'build', 'build the website', ->
  run 'node_modules/.bin/jade *.jade'

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

