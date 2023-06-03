$(document).ready(function(){
    console.log("読み込まれました");
    $('.slick-main').slick({
        slidesToShow: 1,
        slidesToScroll: 1,
        infinite: false,
        centerMode: true,
        centerPadding: '0px',
        asNavFor: '.slick-thumbnail'
    });

    $('.slick-thumbnail').slick({
        slidesToShow: 3,
        asNavFor: '.slick-main',
        centerPadding: '0px',
        focusOnSelect: true,
    });

    $('.slick-product-new1').slick({
        slidesToShow: 4,
        slidesToScroll: 1,
        infinite: false,
        centerPadding: '0px',
        prevArrow: '<button class="slide-arrow prev-arrow"></button>',
        nextArrow: '<button class="slide-arrow next-arrow"></button>',
        responsive: [
            {
            breakpoint: 980,
            settings: {
                slidesToShow: 3
            }
            },
            {
            breakpoint: 700,
            settings: {
                slidesToShow: 2
            }
            }
          ]
    });

    $('.slick-product-new2').slick({
        slidesToShow: 4,
        slidesToScroll: 1,
        infinite: false,
        centerPadding: '0px',
        prevArrow: '<button class="slide-arrow prev-arrow"></button>',
        nextArrow: '<button class="slide-arrow next-arrow"></button>',
        responsive: [
            {
            breakpoint: 980,
            settings: {
                slidesToShow: 3
            }
            },
            {
            breakpoint: 700,
            settings: {
                slidesToShow: 2
            }
            }
          ]
    });
});