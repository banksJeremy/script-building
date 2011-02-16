exports.bar = function() {
    $("body").append($("<p>", { css: { font: "300% Bold Georgia" },
                                text: "Hello World" }));
};
