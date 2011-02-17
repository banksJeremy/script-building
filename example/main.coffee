require "./jquery-1.5.0"

document.title = "Crude Canvas Example"

$("html").css width: "100%", height: "100%", padding: 0, overflow: "hidden"
body = $("body")
canvas = $("<canvas width=" + $("html").width() + " height=" + $("html").height() + ">").appendTo body
g2d = canvas[0].getContext "2d"

body.css background: "black", padding: 0, margin: 0
canvas.css background: "black"

g2d.beginPath()
g2d.moveTo 0, 0
g2d.lineTo 210, 210
g2d.strokeStyle = "white"
g2d.stroke()

canvas.click (event) ->
    g2d.lineTo event.offsetX, event.offsetY
    g2d.fillStyle = "rgba(" + parseInt(Math.random() * 256) + ", " + parseInt(Math.random() * 256) + ", " + parseInt(Math.random() * 256) + ", " + 1 + ")"
    g2d.fill()
    g2d.stroke()
