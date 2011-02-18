FILES=main.coffee --jQuery --CoffeeScript --underscore

show: clean index.html
	open index.html

clean:
	rm -f *.html

index.html:
	../../scriptBuilder.js $(FILES) > index.html
	../../scriptBuilder.js $(FILES) --data | pbcopy
