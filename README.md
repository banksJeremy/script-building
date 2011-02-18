https://github.com/jeremybanks/script-building/

## `scriptBuilder.js`

    $ ./scriptBuilder.js [--flags] input... > output.html

Produces a web page containing the specified files. CoffeeScript files will be
compiled to JavaScript. The JavaScript files may access each other through
the [CommonJS Modules/1.1](http://wiki.commonjs.org/wiki/Modules/1.1)
interface. Flags are available to include the standard modules `--jQuery`,
`--CoffeeScript` and `--underscore`. Non-script files may be included and
`require()`d using their complete file name; they will return a `data:` URL of
their contents.

The `--data` flag causes the output to be encoded as a `data:` URL.

The compiled page includes two iOS-specific `<meta>` tags to make the page
behave more appropriately when installed as an app.

### Example

    echo 'require("jQuery")("body").css background: require("./image.png")' > main.coffee
    ./scriptBuilder.js --jQuery main.coffee image.png > output.html

This would produce an out.html using jQuery to set the background to the
content of image.png.

Copyright (c) 2011 Jeremy Banks.  
Includes CoffeeScript, Copyright (c) 2011 Jeremy Ashkenas.  
Includes jQuery, Copyright (c) 2011 John Resig.  
Includes underscore.js, Copyright (c) 2011 Jeremy Ashkenas, DocumentCloud.
All released under the MIT license.
