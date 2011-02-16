show: base64Redirect.html
	open base64Redirect.html

page.html:
	../scriptPager.js main.coffee foo.js jquery-1.5.0.js > page.html

base64Redirect.html: page.html
	../base64Redirecter.js page.html > base64Redirect.html
