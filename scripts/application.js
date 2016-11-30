jQuery.noConflict();
(function($) {
  $(function() {
    $(".datepicker").datepicker({
			showOn: "button",
      dateFormat: 'mm/dd/yy',
      changeYear: true,
      onClose: function(dateText, inst) { 
        $(this).focus();
      }
		});

    $(".ui-datepicker-trigger").attr("title", t.calendarInstructions);

    $('#dismiss').click(function() {
      $(this).parent().replaceWith($('#acknowledged').show());
      $.post('../ws/acknowledge_notice.cfm');
    });
  });
})(jQuery);

(function($) {
  $(function() {
    if (!$( '#wb-sec' ).length) {
        $( '#wb-main-in' ).css('float', 'none');
        $( '#wb-main-in' ).css('width', '100%');
    }
  });
})(jQuery);
