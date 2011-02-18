[UP, RIGHT, DOWN, LEFT] = [0..3]

exports.Ant = class Ant
    constructor: (@x = 0, @y = 0, @direction = 0, @color = "rgba(0, 128, 255, .5)") ->
    
    turn: (direction) ->
        @direction = (@direction + 4 + direction) % 4

exports.AntSim = class LangtonAntSim
    drawInterval: 100
    advanceInterval: 5
    
    constructor: (@canvas, @width, @height = @width) ->
        @graphics = @canvas.getContext "2d"
        @ants = [ new Ant ]
        
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
        
        # draw ants
        for ant in @ants
            @drawPixel ant.x, ant.y, ant.color
        
    advance: ->
        for ant in @ants
            ant.turn if @cell(ant.x, ant.y) then +1 else -1
            
            @cell ant.x, ant.y, (not @cell ant.x, ant.y)
            
            if ant.direction is UP
                ant.y += 1
            else if ant.direction is RIGHT
                ant.x += 1
            else if ant.direction is DOWN
                ant.y -= 1
            else if ant.direction is LEFT
                ant.x -= 1
        
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
    
    