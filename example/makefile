show: clean base64Redirect.html
	open base64Redirect.html

clean:
	rm *.html

scriptPage.html:
	../scriptPager.js main.coffee jquery-1.5.0.js > scriptPage.html

base64Redirect.html: scriptPage.html
	../base64Redirecter.js scriptPage.html > base64Redirect.html
