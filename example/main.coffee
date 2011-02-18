document.title = "Example: Langton's Ant"
size = 64

[UP, RIGHT, DOWN, LEFT] = [0..3]
TURN_RIGHT = +1
TURN_LEFT  = +3

drawState = (graphics, state) ->
    oldStyle = graphics.fillStyle
    
    graphics.fillStyle = "rgba(0, 0, 0, .35)"
    graphics.fillRect 0, 0, size, size
    graphics.fillStyle = oldStyle
    
    for x in [- size / 2...size / 2]
        for y in [- size / 2...size / 2]
            if state.cells[y]?[x]
                graphics.fillRect size / 2 + x,
                                  size / 2 + y, 1, 1
    
    
    graphics.fillStyle = "rgb(0, 128, 255)"
    graphics.fillRect size / 2 + state.turtle.x,
                      size / 2 + state.turtle.y, 1, 1
    
    # add a glow in the direction it is looking
    graphics.fillStyle = "rgba(0, 128, 255, .25)"
    
    if state.turtle.direction is UP
        graphics.fillRect size / 2 + state.turtle.x,
                          size / 2 + state.turtle.y + 1, 1, 1
    else if state.turtle.direction is RIGHT
        graphics.fillRect size / 2 + state.turtle.x + 1,
                          size / 2 + state.turtle.y, 1, 1
    else if state.turtle.direction is DOWN
        graphics.fillRect size / 2 + state.turtle.x,
                          size / 2 + state.turtle.y - 1, 1, 1
    else if state.turtle.direction is LEFT
        graphics.fillRect size / 2 + state.turtle.x - 1,
                          size / 2 + state.turtle.y, 1, 1
    
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
    
    null

runGame = (canvas) ->
    graphics = canvas.getContext "2d"
    graphics.fillStyle = canvas.style.color
    
    state =
        cells: {} # false are white
        turtle: x: 0, y: 0, direction: UP
    
    return {
        state: state
        tickerID: setInterval (-> tickState state), 1
        drawerID: setInterval (-> drawState graphics, state), 75 }

document.body.innerHTML =
    "<canvas width=#{size} height=#{size}>"

canvas = document.getElementsByTagName("canvas")[0]

document.body.style.background = canvas.style.background = "black"
document.body.style.color      = canvas.style.color      = "white"

document.body.style.padding = 0

canvas.style.width = "100%"
canvas.style.color = "rgb(225, 200, 175)"

runGame canvas
