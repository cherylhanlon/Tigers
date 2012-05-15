// DOM ready
$(function() {

    // Create the dropdown base
    $("<select />").appendTo(".navigation");

    // Create default option "Go to..."
    $("<option />", {
        "selected": "selected",
        "value": "",
        "text": "Go to..."
    }).appendTo("nav select");

    // Populate dropdown with menu items
    $(".navigation a").each(function() {
        var el = $(this);
        $("<option />", {
            "value": el.attr("href"),
            "text": el.text()
        }).appendTo(".navigation select");
    });
    $(".navigation select").change(function() {
        window.location = $(this).find("option:selected").val();
    });
});