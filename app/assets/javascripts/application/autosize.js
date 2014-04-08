(function($) {
    jQuery.timeago.settings.allowFuture = true;
    $(document).on('ready page:load', function() {
        $('textarea').autosize();
        $('[data-behaviour~=datepicker]').datepicker({
            format: 'yyyy-mm-dd',
            language: 'en',      // should be set with current locale
            autoclose: true
        });
        $("[data-toggle='tooltip']").tooltip();
    });
})(jQuery);