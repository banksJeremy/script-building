_ = require "underscore"
$ = require "jQuery"
CoffeeScript = require "CoffeeScript"

_.each ["Everything is working"], (message) ->
    $("body").append $ "<p>", text: CoffeeScript.compile "all is well"