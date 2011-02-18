document.title = "Example: Langton's Ant"
size = 48

document.body.innerHTML =
    "<canvas width=#{size} height=#{size}>"

canvas = document.getElementsByTagName("canvas")[0]

document.body.style.background = canvas.style.background = "black"
document.body.style.color      = canvas.style.color      = "white"

canvas.style.width = "100%"
canvas.style.color = "rgba(225, 200, 175, 1)"

{AntSim, Turtle} = require("./langton")

sim = new AntSim canvas, size

sim.turtles = [
    new Turtle -5, -7, 0
    new Turtle  5, 8, 2
]

sim.run()
