#!/usr/bin/env node
var util = require("util"),
    fs = require("fs"),
    path = require("path"),

    htmlTemplate = "<!doctype html><head><meta charset=\"utf-8\"><title>" +
        "Script</title>" +
        "<meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\">" +
        "<meta name=\"apple-mobile-web-app-capable\" content=\"yes\">"+
        "<body><noscript>JavaScript is required.</noscript>",

    requireCode = "var require = function(filename) {" +
        "if (! (filename in require.loaded)) {" +
            "var contents = require.files[filename];" +
            
            "if (! contents) {" +
                "throw new Error(\"Required file was not compiled: \" + filename);" +
            "};" +
        
            "require.loaded[filename] = contents();" +
        "};" +
        
        "return require.loaded[filename];" +
    "};" +
    
    "require.files = {};" +
    "require.loaded = {};",

    escapeDoubleQuotes = function(s) {
        return s.replace(/\\/g, "\\\\").replace(/"/g, "\\\"");
    },

    formatFile = function(name, contents) {
        return "require.files[\"" + escapeDoubleQuotes(filename) + "\"] = " + 
                    "function() { return (function() {" +
                        "var exports = this;" +
                        "(function() {\n" +
                        "// BEGIN FILE: " + name + "\n    " +
                            contents.replace(/<\/script>/g, "<\\057script>").
                                     replace(/\n/g, "\n    ").
                                     replace(/\n *$/, "\n") +
                        "// END FILE: " + name + "\n})();" +
                        "return exports;" +
                    "}).call({});};";
    },

    formatScript = function(filenames, files) {
        var contents, i;
    
        parts = ["<script>", requireCode];
  
        for (i = 0; i < filenames.length; i += 1) {
            filename = filenames[i];
            contents = files[filename];
            parts.push(formatFile(filename, contents));
        };
    
        for (i = 0; i < filenames.length; i += 1) {
            parts.push("require(\"" + escapeDoubleQuotes(filenames[i]) + "\");")
        };
    
        parts.push("</script>");
        return parts.join("");
    },
    
    main = function() {
        if (arguments.length > 2) {
            var i,
                files = {};
                filenames = [];
        
            for (i = 2; i < arguments.length; i += 1) {
                var inputFilename = arguments[i],
                    lastDotIndex = inputFilename.lastIndexOf("."),
                    filename = path.normalize(inputFilename.substr(0, lastDotIndex)),
                    extension = inputFilename.substr(lastDotIndex + 1);
                
                if (filename.substr(0, 3) !== "../") {
                    filename = "./" + filename;
                };
                
                filenames.push(filename);
                
                if (extension == "js") {
                    files[filename] = fs.readFileSync(inputFilename, "utf-8");
                } else if (extension == "coffee") {
                    files[filename] = require("./coffeescript-1.0.0").
                        CoffeeScript.
                        compile(fs.readFileSync(inputFilename, "utf-8"));
                } else {
                    throw new Exception("Unknown file extension: " + extension);
                };
            };
            
            return htmlTemplate + formatScript(filenames, files);
        } else if (arguments.length === 2) {
            return ["Usage:", arguments[0], arguments[1], "filenames..."].join(" ");
        } else {
            return ["Usage:", arguments[0], "filenames..."].join(" ");
        };
    };

console.log(main.apply(this, process.argv));
