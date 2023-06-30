$(document).on("turbo:load", function () {  
    $(".add-cart").click(function() {
        $(".ec-modal").css("display", "block");
    });

    $(".ec-modal-close").click(function() {
        $(".ec-modal").css("display", "none");
    });
});