https://github.com/jeremybanks/script-building/

Copyright (c) 2011 Jeremy Banks.  
Includes CoffeeScript, Copyright (c) 2011 Jeremy Ashkenas.  
Includes jQuery, Copyright (c) 2011 John Resig.  
All released under the MIT license.

Here are two node.js scripts for compiling script into pages.

## `scriptPager.js`

    $ ./scriptPager.js [--jq] [--cs] inputFiles... > output.html

Produces a web page from input files. If a file is CoffeeScript or JavaScript
it will be evaluated in the page and available via a CommonJS-style
`require()` function. Other types of files may be `require()`d using their
full filename to get their contents as a `data:` url.

The flags `--jq` and `--cs` are used to include the standard libraries
`jQuery` and `CoffeeScript`.

### Example

    echo 'require("jQuery")("body").css background: require("./image.png")' > main.coffee
    ./scriptPager.js --jq main.coffee image.png > output.html

This would produce an outout.html using jQuery to set the background to the
content of image.png.

## `dataRedirect.js`

    $ ./dataRedirect.js input > output.html

Produces a web page redirecting with a `<meta>` tag to a `data:` url of the
given file. Can be used with `scriptPager.js` to create get the user to a
`data:` URL of a compiled script bundle so that they can bookmark it for
offline use. This works well as an iOS App.
