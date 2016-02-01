au! BufWritePost {about,contact,fees,treatments,thanks,index}.jade !node_modules/.bin/jade -P <afile>
au! BufWritePost layout.jade !node_modules/.bin/jade -P {about,contact,fees,treatments,thanks,index}.jade
au! BufWritePost *.coffee !node_modules/.bin/coffee -cm <afile>
au! BufWritePost *.styl !node_modules/.bin/stylus -m <afile>
