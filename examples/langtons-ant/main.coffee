document.title = "Langton's Ant"
size = 64

document.body.innerHTML =
    "<canvas width=#{size} height=#{size}>"

canvas = document.getElementsByTagName("canvas")[0]

document.body.style.background = canvas.style.background = "black"
document.body.style.color      = canvas.style.color      = "white"

canvas.style.width = "100%"
canvas.style.color = "rgba(225, 200, 175, 1)"

{AntSim, Ant} = require("./langton")

sim = new AntSim canvas, size

sim.ants = [
    new Ant -5, -7, 0, "rgba(0, 128, 255, .75)"
    new Ant  5,  8, 2, "rgba(255, 0, 128, .75)"
]

sim.run()
