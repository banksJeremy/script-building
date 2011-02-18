#!/usr/bin/env node
var util = require("util"),
    fs = require("fs"),
    path = require("path");

var debuggable = true;
// set to false when --data

var scriptRelPath = function(s) {
    return path.join(path.dirname(fs.realpathSync(process.argv[1])), s);
};

var stdFiles = {
    "--jQuery": {
        name: "jQuery",
        path: scriptRelPath("./lib/jquery-1.5.0.js") },
    
    "--CoffeeScript": {
        name: "CoffeeScript",
        path: scriptRelPath("./lib/coffeescript-1.0.0.js") },
    
    "--underscore": {
        name: "underscore",
        path: scriptRelPath("./lib/underscore-1.1.4.js")},
};

var doubleQuote = function(s) {
    return '"' + s.replace(/\\/g, "\\\\").replace(/"/g, "\\\"") + '"';
};

var templateStart =
    '<!doctype html><html>' + 
    '<head>' +
        '<meta charset="utf-8">' +
        '<title>Script</title>' +
        '<meta name="apple-mobile-web-app-status-bar-style" content="black">' +
        '<meta name="apple-mobile-web-app-capable" content="yes">' +
    '<body>' +
        '<noscript>JavaScript is required.</noscript>' +
        '<script>' +
            'var require = function(name) {' +
                'if (name in require.modules) {' +
                    'var module = require.modules[name];' +
                
                    'if (module.exported !== undefined) {' +
                        'return module.exported;' +
                    '} else {' +
                        'return module.exported = module.load();' +
                    '}' +
                '} else {' +
                    'throw new Error("Required file was not compiled: " + name);' +
                '}' +
            '};' +
        
            'require.modules = {};' +
        '</script>';

var templateScript = function(name, source) {
    var quotedName = doubleQuote(name),
        preparedSource = source.replace(/<\/script>/g, "<\\057script>");
    
    if (! debuggable) {
        // collapse whitespace around newlines
        preparedSource = preparedSource.replace(/[ \t]*[\n$^]\s*/g, "")
    } else {
        // indent files and comment with filenames
        preparedSource = "\n/* --- begin file: " + name + " --- */\n    " + preparedSource.replace(/\n/g, "\n    ").replace(/\n? *$/, "\n") + "/* --- end file: " + name + " --- */\n";
    };
                 
    return (
        '(function() {' +
            'var module = {' +
                'id: ' + quotedName + ',' +
                'load: function() {' +
                    'var exports = {};' +
                
                    '(function() {' +
                        preparedSource +
                    '})(exports);' +
                
                    'return exports;' +
                '}' +
            '};' +
            
            'require.modules[module.id] = module;' +
        '})();');
};

var deduplicate = function(array) {
    var result = [],
        added = {};
    
    for (var i = 0; i < array.length; i += 1) {
        if (! (array[i] in added)) {
            result.push(array[i]);
            added[array[i]] = true;
        };
    };
    
    return result;
};

var templatePage = function(filenames, files) {
    filenames = deduplicate(filenames);
    
    var parts = [templateStart, "<script>"];
    
    for (var i = 0; i < filenames.length; i += 1) {
        var filename = filenames[i];
        parts.push(templateScript(filename, files[filename]));
    };
    
    for (var i = 0; i < filenames.length; i += 1) {
        var filename = filenames[i];
        parts.push('require(' + doubleQuote(filename) + ');');
    };
    
    parts.push('</script>\n');
    
    return parts.join("");
};

var main = function() {
    if (arguments.length) {
        var files = {}, filenames = [], asData = false;
        
        arguments = Array.prototype.slice.call(arguments).filter(function(argument) {
            if (argument == "--data") {
                asData = true;
                debuggable = false;
                
                return false;
            } else {
                return true;
            };
        });
        
        for (var i = 0; i < arguments.length; i += 1) {
            var filename = arguments[i];
            
            if (filename in stdFiles) {
                var file = stdFiles[filename];
                
                files[file.name] = fs.readFileSync(file.path, "utf-8");
                filenames.push(file.name);
            } else {
                filename = path.normalize(filename);
                
                if (filename.substr(0, 3) != "../") {
                    filename = "./" + filename;
                };
                
                var lastDotIndex = filename.lastIndexOf("."),
                    extension = filename.substr(lastDotIndex + 1);
                
                if ({coffee: true, js: true}[extension]) {
                    var textContent = fs.readFileSync(filename, "utf-8");
                    
                    /* strip extension from includable scripts */
                    filename = filename.substr(0, lastDotIndex);
                    
                    if (extension == "coffee") {
                        textContent = require(stdFiles["--CoffeeScript"].path).CoffeeScript.compile(textContent);
                    };
                    
                    files[filename] = textContent;
                } else {
                    var base64Content = fs.readFileSync(filename, "base64");
                    
                    var mime = {
                        "png": "image/png"
                    }[extension] || "application/octet-stream";
                    
                    files[filename] = "exports = \"data:" + mime + ";base64," + base64Content + "\";";
                };
                
                filenames.push(filename);
            };
        };
        
        var page = templatePage(filenames, files);
        
        if (asData) {
            process.stdout.write("data:text/html;base64," + (new Buffer(page)).toString("base64"));
            
            // You can use URL encoding the URL and leave it as utf-8 instead
            // of base64 encoding it, but this actually made my filesizes
            // larger, not smaller. The code was this:
            // 
            // process.stdout.write("data:text/html;charset=utf-8," + encodeURIComponent(page));
        } else {
            process.stdout.write(page);
        };
    } else {
        process.stdout.write(["Usage:", path.basename(process.argv[1]),
                              "[--flags]", "files...", ">", "output.html"]
                             .join(" ") + "\n");
        process.stdout.write("\n");
        process.stdout.write(" --data           Encode output as a data: URL.\n");
        process.stdout.write(" --jQuery         Compile-in jQuery standard module.\n");
        process.stdout.write(" --CoffeeScript   Compile-in CoffeeScript standard module.\n");
        process.stdout.write(" --underscore     Compile-in underscore.js standard module.\n");
        
    };
};

main.apply(this, process.argv.slice(2));
