FILES=main.coffee langton.coffee

show: clean scriptPage.html dataRedirect.html
	open scriptPage.html

clean:
	rm *.html

scriptPage.html:
	../scriptPager.js $(FILES) > scriptPage.html

dataRedirect.html: scriptPage.html
	../dataRedirecter.js scriptPage.html > dataRedirect.html
