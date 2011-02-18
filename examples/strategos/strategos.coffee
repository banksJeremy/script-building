jQuery = require "jQuery"

exports.images = images =
    tank: new Image

images.tank.src = require "./tank.png"

exports.Country = class Country
    constructor: (@game, @color, @points) ->
        @draw()
    
    draw: ->
        @game.graphics.fillStyle = @color
        @game.graphics.beginPath()
        
        @game.graphics.moveTo @points[0][0] * @game.width, @points[0][1] * @game.height
        
        for [x, y] in @points[1...@points.length]
            @game.graphics.lineTo x * @game.width, y * @game.height
        
        @game.graphics.lineTo @points[0][0] * @game.width, @points[0][1] * @game.height
        
        @game.graphics.fill()
        
exports.Game = class Game
    width: 600
    height: 400
    
    constructor: (@canvas) ->
        @graphics = @canvas.getContext "2d"
        @canvas.width = @width
        @canvas.height = @height
        
        @canvas.style.background = "#111"
        
        @graphics.drawImage images.tank, 200, 300
        
        @countries = [
            new Country(this, "red", [
                [0.05, 0.05]
                [0.02, 0.15]
                [0.10, 0.20]
            ]),
            new Country(this, "green", [
                [0.30, 0.30]
                [0.35, 0.40]
                [0.35, 0.70]
                [0.50, 0.60]
                [0.60, 0.60]
            ]),
        ]
    
    draw: ->
        for country in @countries
            country.draw()
    
    clear: ->
        @canvas.fillStyle = @canvas.style.background
        @canvas.drawRect 0, 0, @width, @height
    
        @graphics.strokeStyle = "white"
        @graphics.beginPath()
        @graphics.moveTo 100, 100
        @graphics.lineTo 50, 50
        @graphics.lineTo 100, 500
        @graphics.stroke()
        
        
