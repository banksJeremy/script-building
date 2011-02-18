https://github.com/jeremybanks/script-building/

Copyright (c) 2011 Jeremy Banks.  
Includes CoffeeScript, Copyright (c) 2011 Jeremy Ashkenas.  
Includes jQuery, Copyright (c) 2011 John Resig.  
Includes underscore.js, Copyright (c) 2011 Jeremy Ashkenas, DocumentCloud.
All released under the MIT license.

Two node.js scripts I'm using to build scripts into pages.

## `scriptPager.js`

    $ ./scriptPager.js [--flags] input... > output.html

Produces a web page containing the specified files. CoffeeScript files will be
compiled to JavaScript. The JavaScript files may access each other through
the [CommonJS Modules/1.1](http://wiki.commonjs.org/wiki/Modules/1.1)
interface. Flags are available to include the standard modules `--jQuery`,
`--CoffeeScript` and `--underscore`. Non-script files may be included and
`require()`d using their complete file name; they will return a `data:` URL of
their contents.

The compiled page includes two iOS-specific `<meta>` tags to make the page
behave more appropriately when installed as an app.

### Example

    echo 'require("jQuery")("body").css background: require("./image.png")' > main.coffee
    ./scriptPager.js --jQuery main.coffee image.png > output.html

This would produce an out.html using jQuery to set the background to the
content of image.png.

## `dataRedirect.js`

    $ ./dataRedirect.js input > output.html

Produces a web page redirecting with a `<meta>` tag to a `data:` url of the
given file. Can be used with `scriptPager.js` to create get the user to a
`data:` URL of a compiled script bundle so that they can bookmark it for
offline use. This works well as an iOS App.
