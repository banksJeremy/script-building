FILES=main.coffee

show: clean base64Redirect.html
	open base64Redirect.html

clean:
	rm *.html

scriptPage.html:
	../scriptPager.js $(FILES) > scriptPage.html

base64Redirect.html: scriptPage.html
	../base64Redirecter.js scriptPage.html > base64Redirect.html
