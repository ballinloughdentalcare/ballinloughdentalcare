# Ballinlough Dental Care

A custom node.js application. Uses Redis as a store for the CMS content, which
is written in Markdown. The styles can also be updated on the fly.

## Local setup

Make sure you have Git, Redis and NodeJS installed. Then clone the repo

    git clone git@github.com/bjjb/ballinloughdentalcare

In the new directory, run

    npm run-script setup

...or, if you have coffee-script installed globally, you can just run

    cake setup

This copies the seed content (in public/) to the Redis store if they are not
already there. Conversely, to repopulate the static files, run `cake build` or
`npm run-script build`. (You cannot run this command on Heroku, because the
file-system there is read-only; however, you can run it locally and redeploy.

## Deployment

If you haven't already done so, add the heroku git remote:

    git remote add heroku git@heroku.com/ballinloughdentalcare.git

To deploy, just push to Heroku: `git push heroku master`.

If you want to do other things, like change the config variables, you'll need
the Heroku Toolbelt.

## TODO

...

[![Codeship Status](https://codeship.io/projects/b7ca1640-0fe9-0132-3a96-42e120fa204e/status)](https://codeship.io/projects/32740)
