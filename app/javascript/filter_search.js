$(document).on("turbo:load", function () {
    var $brandToggle = $('.brand-toggle');
    var $searchBrand = $('.search-brand');
    var $colorToggle = $('.color-toggle');
    var $searchColor = $('.search-color');
    var $shapeToggle = $('.shape-toggle');
    var $searchShape = $('.search-shape');
    var $carrying_styleToggle = $('.carrying_style-toggle');
    var $searchCarrying_style = $('.search-carrying_style');
    var $styleToggle = $('.style-toggle');
    var $searchStyle = $('.search-style');
    var $closure_methodToggle = $('.closure_method-toggle');
    var $searchClosure_method = $('.search-closure_method');
  
    $brandToggle.click(function() {
      $searchBrand.slideToggle();
    });

    $colorToggle.click(function() {
        $searchColor.slideToggle();
    });

    $shapeToggle.click(function() {
        $searchShape.slideToggle();
    });
    
    $carrying_styleToggle.click(function() {
        $searchCarrying_style.slideToggle();
    });

    $styleToggle.click(function() {
        $searchStyle.slideToggle();
    });

    $closure_methodToggle.click(function() {
        $searchClosure_method.slideToggle();
    });

    $('.filter-search-btn').click(function(event) {
        event.stopPropagation();
    });
  });

  