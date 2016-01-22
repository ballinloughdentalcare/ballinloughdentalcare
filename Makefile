# Makefile for ballinloughdentalcare
.PHONY: all clean

# Creates CSS and HTML files from sources.
all:
	sass --update assets/sass:assets/css
	jade {index,about,treatments,fees,contact}.jade

clean:
	rm -f {index,about,treatments,fees,contact}.html
	rm -f assets/css/{main,ie8,ie9}.css

