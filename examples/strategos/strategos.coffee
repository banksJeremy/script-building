jQuery = require "jQuery"

exports.images = images =
    tank: new Image

images.tank.src = require "./tank.png"

exports.Polygon = class Polygon
    constructor: (@points) ->
    
    containsPoint: (x, y) ->
        for index, value in @points
            a = array[index]
            b = @points[(index + 1) % @point.length]
            
            if blah
                return false
        
        return true

exports.Country = class Country extends Polygon
    # points must be defined closewise
    
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
    
            

exports.Unit = class Unit
    constructor: (@game, @type, @quantity, @x, @y) ->
    
    draw: ->
        @game.graphics.drawImage images.tank, @x * @game.width - images[@type].width / 2 , @y * @game.height - images[@type].height / 2 
        @game.graphics.textAlign = "center"
        @game.graphics.textBaseline = "middle"
        @game.graphics.font = "bold 16px Georgia"
        @game.graphics.fillStyle = "white"
        @game.graphics.fillText String(@quantity), @x * @game.width - images[@type].width / 6, @y * @game.height
    
    split: (n) ->
        copy = new @constructor 

exports.Tank = class Tank extends Unit
    @type = "tank"
    constructor: (@game, @quantity, @x, @y) ->
        

exports.Game = class Game
    width: 600
    height: 400
    
    constructor: (@canvas) ->
        @graphics = @canvas.getContext "2d"
        @canvas.width = @width
        @canvas.height = @height
        
        @canvas.style.background = "#111"
        
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
        
        @units = units = [
            new Unit this, "tank", 12, 0.5, 0.5
        ]
        
        jQuery(@canvas).mousemove (event) ->
            x = event.offsetX / jQuery(this).width()
            y = event.offsetY / jQuery(this).height()
            
            units[0].x = x
            units[0].y = y
        
        outerThis = this
        
        jQuery(@canvas).click (event) ->
            x = event.offsetX / jQuery(this).width()
            y = event.offsetY / jQuery(this).height()
            
            units.push new Unit outerThis, units[0].type, units[0].quantity / 2, x, y
            units[0].quantity /= 2
            
            units[0].x = x
            units[0].y = y
    
    draw: ->    
        @clear()
        
        for country in @countries
            country.draw()
        
        for unit in @units
            unit.draw()
        
    
    clear: ->
        @graphics.fillStyle = @canvas.style.background
        @graphics.fillRect 0, 0, @width, @height
    
        
