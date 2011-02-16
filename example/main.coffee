require "./jquery-1.5.0"
foo = require "./foo"

$("body").append $("<p>").append $("<button>", text: "Example").click ->
    foo.bar()
