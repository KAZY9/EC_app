$(document).ready(function () {
    var $navbarToggle = $('#navbar-toggle');
    var $hiddenMenu = $('.hidden-menu');
    var $hiddenMenuLinks = $('#hidden-menu a');
  
    $navbarToggle.click(function() {
      $(this).toggleClass('open');
      $hiddenMenu.slideToggle();
    });
  
    $hiddenMenuLinks.click(function(){
      $hiddenMenu.slideUp();
    });

    $(document).click(function(event) { 
      if(!$(event.target).closest('#navbar-toggle, .hidden-menu').length) {
        if($hiddenMenu.is(":visible")) {
          $hiddenMenu.slideUp();
          $navbarToggle.removeClass('open');
        }
      }        
    });
  
    $(window).resize(function() {
      var windowWidth = $(window).width();
      if(windowWidth > 980) {
        $hiddenMenu.hide();
        $navbarToggle.removeClass('open');
      }
    });

    $navbarToggle.click(function() {
      $('body').removeClass('modal-open');
    });
  });

  