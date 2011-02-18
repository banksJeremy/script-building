FILES=main.coffee langton.coffee

show: clean scriptPage.html base64Redirect.html
	open scriptPage.html

clean:
	rm *.html

scriptPage.html:
	../scriptPager.js $(FILES) > scriptPage.html

base64Redirect.html: scriptPage.html
	../base64Redirecter.js scriptPage.html > base64Redirect.html
