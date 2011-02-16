require("./jquery-1.5.0")
exports.bar = function() {
    $("body").append($("<p>", { css: { font: "300% Bold Georgia" },
                                text: "Hello World" }));
};
