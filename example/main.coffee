require "./jquery-1.5.0"

body = $("body")
canvas = $("<canvas width=420 height=420>").appendTo body
g2d = canvas[0].getContext "2d"

body.css background: "black"
canvas.css background: "black"

g2d.beginPath()
g2d.moveTo 0, 0
g2d.lineTo 50, 50
g2d.lineTo  0, 25
g2d.fillStyle = "pink"
g2d.fill()
g2d.strokeStyle = "white"
g2d.stroke()
g2d.lineTo 75, 75
g2d.lineTo  0, 50
g2d.fillStyle = "rgba(0, 255, 128, .5)"
g2d.fill()
g2d.stroke()
