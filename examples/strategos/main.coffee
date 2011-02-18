document.title = "Strategos"

jQuery = require "jQuery"
strategos = require "./strategos"

jQuery ($) ->
    document.body.style.background = "black"
    
    canvas = $("<canvas>").appendTo $("body")
    canvas.css width: "100%", background: "black"
    
    game = new strategos.Game canvas[0]
    
    game.draw()
    
    null


