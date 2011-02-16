#!/usr/bin/env node
var process = require("process"),
    util = require("util"),
    fs = require("fs"),
    CoffeeScript = require("./coffeescript-1.0.0").CoffeeScript,

    htmlTemplate = "<!doctype html><head><meta charset=\"utf-8\"></head><body>",

    requireCode = "var require = function(filename) {" +
        "if (! (filename in require.loaded)) {" +
            "var contents = require.files[filename];" +
            
            "if (! contents.length) {" +
                "throw new Error(\"Required file is unavailable: \" + filename);" +
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
                            contents.replace(/<\/script>/g, "<\\057script>") +
                        "\n})();" +
                        "return exports;" +
                    "}).call({});};";
    },

    formatScript = function(filenames, files) {
        var contents, i;
    
        parts = ["<script>", requireCode];
  
        for (i = 0; i < filenames.length, i += 1) {
            filename = filenames[i];
            contents = files[filename];
            parts.push(formatFile(filename, contents));
        };
    
        for (filename in filenames) {
            parts.push("require(\"" + escapeDoubleQuotes(filename) + "\");")
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
                    filename = inputFilename.substr(0, lastDotIndex),
                    extension = inputFilename.substr(lastDotIndex + 1);
                
                filenames.push(filename);
                
                if (extension == "js") {
                    files[filename] = fs.readFileSync(inputFilename);
                } else if (extension == "js") {
                    files[filename] = fs.readFileSync(inputFilename);
                } else {
                    throw new Exception "Unknown file extension: " + extension;
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
