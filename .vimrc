au! BufWritePost layout.jade !jade -P {index,about,treatments,fees,contact,elements}.jade
au! BufWritePost {index,about,treatments,fees,contact,elements}.jade !jade -P <afile>
au! BufWritePost {style,variables,mixins,base,grid,main,footer}.styl !stylus -m style.styl
au! BufWritePost script.coffee !coffee -cm <afile> 
