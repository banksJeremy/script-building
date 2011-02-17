document.title = "Example: Langton's Ant"
[width, height] = [32, 32]

[UP, RIGHT, DOWN, LEFT] = [0..3]
TURN_RIGHT = +1
TURN_LEFT  = +3

drawState = (graphics, state) ->
    graphics.clearRect 0, 0, width, height
    
    for x in [0...width]
        for y in [0...height]
            if state.cells[y]?[x]
                graphics.fillRect x, y, 1, 1
    
    oldStyle = graphics.fillStyle
    
    graphics.fillStyle = "rgb(0, 128, 255)"
    graphics.fillRect state.turtle.x, state.turtle.y, 1, 1
    
    # add a glow in the direction it is looking
    graphics.fillStyle = "rgba(0, 128, 255, .25)"
    
    if state.turtle.direction is UP
        graphics.fillRect state.turtle.x, state.turtle.y + 1, 1, 1
    else if state.turtle.direction is RIGHT
        graphics.fillRect state.turtle.x + 1, state.turtle.y, 1, 1
    else if state.turtle.direction is DOWN
        graphics.fillRect state.turtle.x, state.turtle.y - 1, 1, 1
    else if state.turtle.direction is LEFT
        graphics.fillRect state.turtle.x - 1, state.turtle.y, 1, 1
    
    graphics.fillStyle = oldStyle
    
    null

tickState = (state) ->
    if state.cells[state.turtle.y]?[state.turtle.x]
        state.turtle.direction = (state.turtle.direction + TURN_RIGHT) % 4
    else
        state.turtle.direction = (state.turtle.direction + TURN_LEFT) % 4
    
    (state.cells[state.turtle.y] ?= {})[state.turtle.x] =
        not state.cells[state.turtle.y]?[state.turtle.x]
    
    if state.turtle.direction is UP
        state.turtle.y += 1
    else if state.turtle.direction is RIGHT
        state.turtle.x += 1
    else if state.turtle.direction is DOWN
        state.turtle.y -= 1
    else if state.turtle.direction is LEFT
        state.turtle.x -= 1
    
    console.log "Direction:", state.turtle.direction
    
    null

runGame = (canvas) ->
    graphics = canvas.getContext "2d"
    graphics.fillStyle = canvas.style.color
    
    state =
        cells: {} # false are white
        turtle:
            x: parseInt width / 2
            y: parseInt height / 2
            direction: 0
    
    return {
        state: state
        tickerID: setInterval (-> tickState state), 100
        drawerID: setInterval (-> drawState graphics, state), 100 }

document.body.innerHTML =
    "<canvas width=#{width} height=#{height}>"

canvas = document.getElementsByTagName("canvas")[0]

document.body.style.background = canvas.style.background = "black"
document.body.style.color      = canvas.style.color      = "white"

document.body.style.padding = 0

canvas.style.width = "100%"
canvas.style.border = "1px sold white"

runGame canvas
