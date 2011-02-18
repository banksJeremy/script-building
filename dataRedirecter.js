#!/usr/bin/env node
var fs = require("fs"),
    
    extensionMimes = {
        html: "text/html",
        js: "application/javascript",
    
        unknown: "application/octet-stream"
    },

    mimeFromFilename = function(filename) {
        var dotIndex = filename.lastIndexOf("."),
            extension = dotIndex !== -1 ? filename.substr(dotIndex + 1) : null;
            mime = extensionMimes[extension];
        
        return mime || extensionMimes.unknown;
    },
    
    filename = process.argv[2],
    
    redirectingHTML = function(url) {
        return "<!doctype html><html><head><meta charset=\"utf-8\">" + 
            "<title>Loading...</title><meta http-equiv=\"refresh\" " +
            "content=\"0;url=" + url + "\"><body>Loading...";
    };

if (filename) {
    console.log(redirectingHTML(
        "data:" + mimeFromFilename(filename) +
        ";base64," + fs.readFileSync(filename).toString("base64")));
} else {
    console.log(["Usage:", process.argv[0], process.argv[1], "file"].join(" "));
};
