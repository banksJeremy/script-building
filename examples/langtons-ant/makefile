FILES=main.coffee langton.coffee image.png

show: clean scriptPage.html dataRedirect.html
	open scriptPage.html

clean:
	rm -f *.html

scriptPage.html:
	../../scriptPager.js $(FILES) > scriptPage.html

dataRedirect.html: scriptPage.html
	../../dataRedirecter.js scriptPage.html > dataRedirect.html
