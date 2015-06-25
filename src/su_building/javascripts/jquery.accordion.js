(function($) {
    
  var allPanels = $('.accordion > .content').hide();
  $('.accordion > .control > a').click(function() {
    allPanels.slideUp();
    $(this).parent().next().slideDown();
    return false;
  });

})(jQuery);
