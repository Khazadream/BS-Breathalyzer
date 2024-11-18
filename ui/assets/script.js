var opentype = "";
var target = 0;
var pipetTimer;
var pipetInterval;
var currentColour = 0;
var colours = [
    "#435870",
    "#DD2C00",
    "#FF6D00",
    "#FFD600",
    "#64DD17",
    "#00BFA5",
    "#00B8D4",
    "#0D47A1",
    "#6200EA",
    "#AA00FF",
    "#C51162",
    "#FFCDD2",
    "#CE93D8",
    "#B39DDB",
    "#90CAF9",
    "#C5E1A5"
]
$(document).ready(function () {
    $(".alcoholmeter").draggable({
        cancel: ".power-btn",
        containment: ".fullscreen",
        start: function (event, ui) {
            $(".pipet").hide()
        },
        drag: function (event, ui) {
        },
        stop: function (event, ui) {
            var top = parseFloat($(".alcoholmeter").css('top'))
            var left = parseFloat($(".alcoholmeter").css('left'))
            var screenWidth = window.innerWidth;
            var screenHeight = window.innerHeight;
            var topPercent = (top / screenHeight) * 100;
            var leftPercent = (left / screenWidth) * 100;
            topPercent = topPercent + 8

            if (leftPercent < 7) {
                leftPercent = leftPercent + 15
                $(".pipet").css({
                    "top": `${topPercent}%`,
                    "left": `${leftPercent}%`,
                    "transform": "scaleX(-1)"
                })
            } else {
                leftPercent = leftPercent - 7
                $(".pipet").css({
                    "top": `${topPercent}%`,
                    "left": `${leftPercent}%`,
                    "transform": "scaleX(1)"
                })
            }
            $(".pipet").show()
        }
    });

    // $(".selectplayer").hide();
    // $(".alcoholmeter").hide();
    // $(".pipet").hide();

    $(document).on('keydown', function (event) {
        if (event.key === 'Escape') {
            if ($('.selectplayer').is(':visible')) {
                $(".selectplayer").fadeOut(500)
                $(".alcoholmeter").draggable("enable");

            } else {
                $.post(`https://${GetParentResourceName()}/close`, JSON.stringify({}))
            }
        }
    });

    $(".power-btn svg").on("click", function () {
        if (opentype === "police") {

            if ($('.selectplayer').is(':visible')) {
                $(".selectplayer").fadeOut(500);
                $(".power-btn svg").css({ "fill": "gray" });

                $(".alcoholmeter").draggable("enable");

            } else {
                $(".power-btn svg").css({ "fill": "rgb(73, 219, 29)" });
                $.post(`https://${GetParentResourceName()}/getClosest`, JSON.stringify({}));
            }


        }
    })
    function formatNmbr(number) {
        const num = parseFloat(number)
        return num.toFixed(2);
    }
    function changeColour(data) {
        $(".panel").css({
            "background-color": data.background,
            "color": data.color
        })
    }

    function addNotify(text) {
        var notif = $(`<div class="notify">${text}</div>`).appendTo(".notify-cont");
        setTimeout(() => {
            notif.remove()
        }, 5000);
    }

    $(".settings-icon").on("click", function () {
        currentColour = currentColour + 1;
        if (currentColour >= colours.length) {
            currentColour = 0
        }
        $(".alcoholmeter").css({
            'border': `0.4vw solid ${colours[currentColour]}`
        })
    })

    window.addEventListener('message', function (event) {
        switch (event.data.action) {
            case "open":
                $(".panel").css({
                    "background-color": "#43454b73",
                    "color": "white"
                })
                opentype = event.data.type;
                $(".pipet").off("mousedown")
                $(".pipet").off("mouseup")
                $(".power-btn svg").css({ "fill": "gray" });
                if (opentype === "police") {
                    target = 0;
                    $(".alcoholmeter").draggable("enable");
                    $(".text").html("--.--");
                } else {
                    $(".power-btn svg").css({ "fill": "rgb(73, 219, 29)" });
                    pipetTimer = 5
                    $(".text").html("5");
                    addNotify(`Blow into the pipette for 5 seconds!`)
                    $(".alcoholmeter").draggable("disable");
                    target = event.data.target;
                    $(".pipet").on("mousedown", function () {
                        pipetInterval = setInterval(() => {
                            pipetTimer = pipetTimer - 1
                            if (pipetTimer === -1) {
                                $.post(`https://${GetParentResourceName()}/showPromil`, JSON.stringify({ target: target }));
                                clearInterval(pipetInterval);
                            } else {
                                $(".text").html(pipetTimer);
                            }
                        }, 1000);
                    })
                    $(".pipet").on('mouseup', function () {
                        clearInterval(pipetInterval);
                        pipetTimer = 5
                    })

                }
                $(".alcoholmeter").fadeIn(500);
                $(".pipet").fadeIn(500);
                break;
            case "setPromil":
                $(".pipet").off("mouseup mouseleave");
                $(".pipet").off("mousedown");
                clearInterval(pipetInterval)
                changeColour(event.data.colors)
                $(".text").html(formatNmbr(event.data.promil));
                addNotify(`Person has ${formatNmbr(event.data.promil)} promil alcohol`)
                setTimeout(function () {
                    $.post(`https://${GetParentResourceName()}/close`, JSON.stringify({}))
                }, 5000)
                break;
            case "setClosestPlayers":
                var players = event.data.players;
                $(".selectplayer").html("")
                $(".player").off("click")
                players.forEach(element => {
                    $(".selectplayer").append(`<div class="player" data-uid="${element.value}">${element.text}</div>`)
                });
                $(".player").on("click", function () {
                    var id = $(this).attr("data-uid")
                    $.post(`https://${GetParentResourceName()}/openAlcoholmeter`, JSON.stringify({ target: id }));
                    $(".selectplayer").hide();
                })
                $(".selectplayer").fadeIn(500);
                $(".alcoholmeter").draggable("disable");
                break;
            case "close":
                $(".pipet").fadeOut(250);
                $(".alcoholmeter").fadeOut(500);
                $(".selectplayer").fadeOut(500);
                break;
        }
    });
});
