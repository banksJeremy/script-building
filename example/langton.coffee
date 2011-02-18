[UP, RIGHT, DOWN, LEFT] = [0..3]

exports.Turtle = class Turtle
    constructor: (@x = 0, @y = 0, @direction = 0) ->
    
    turn: (direction) ->
        @direction = (@direction + 4 + direction) % 4

exports.AntSim = class LangtonAntSim
    drawInterval: 100
    advanceInterval: 5
    
    constructor: (@canvas, @width, @height = @width) ->
        @graphics = @canvas.getContext "2d"
        @turtles = [ new Turtle ]
        
        null
    
    drawPixel: (x, y, color = @canvas.style.color) ->
        @graphics.fillStyle = color
        @graphics.fillRect @width / 2 + x, @height / 2 + y, 1, 1
    
    cell: (x, y, value) ->
        if value?
            (@cell[y] ?= {})[x] = value
        else
            @cell[y]?[x]
    
    draw: (x, y) ->
        # fade current display
        @graphics.fillStyle = "rgba(0, 0, 0, .5)"
        @graphics.fillRect 0, 0, @width, @height
        
        # draw current cell
        for x in [- @width / 2...@width / 2]
            for y in [- @height / 2...@height / 2]
                if @cell(x, y)
                    @drawPixel x, y
        
        # draw turtles
        for turtle in @turtles
            @drawPixel turtle.x, turtle.y, "rgba(0, 128, 255, .5)"
            
            if turtle.direction is UP
                @drawPixel turtle.x, turtle.y + 1, "rgba(0, 128, 255, .25)"
            else if turtle.direction is RIGHT
                @drawPixel turtle.x + 1, turtle.y, "rgba(0, 128, 255, .25)"
            else if turtle.direction is DOWN
                @drawPixel turtle.x, turtle.y - 1, "rgba(0, 128, 255, .25)"
            else if turtle.direction is LEFT
                @drawPixel turtle.x - 1, turtle.y, "rgba(0, 128, 255, .25)"
            
    
    advance: ->
        for turtle in @turtles
            turtle.turn if @cell(turtle.x, turtle.y) then +1 else -1
            
            @cell turtle.x, turtle.y, (not @cell turtle.x, turtle.y)
            
            if turtle.direction is UP
                turtle.y += 1
            else if turtle.direction is RIGHT
                turtle.x += 1
            else if turtle.direction is DOWN
                turtle.y -= 1
            else if turtle.direction is LEFT
                turtle.x -= 1
        
        null
    
    run: ->
        @stop()
        
        @advance.interval = setInterval (=> @advance()), @advanceInterval
        @draw.interval = setInterval (=> @draw()), @drawInterval
        
        null
    
    stop: ->
        if @draw.interval?
            clearInterval @draw.interval
            @draw.interval = null
        
        if @advance.interval?
            clearInterval @advance.interval
            @advance.interval = null
        
        null
    
    