// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
// As of Rails 5.1, jquery_ujs was replaced by rails-ujs, which does not
// depend on jQuery but can be used with applications that use jQuery. This
// application uses jQuery and we've chosen to use jquery_ujs instead of
// rails-ujs, mainly because it makes it easier to override $.rails.allowAction
// to replace JavaScript confirmation dialogs with application-specific modals.
//= require turbolinks
//= require bootstrap-sprockets
//= require select2
//= require jquery-fileupload/basic
//= require lightbox
//= require_tree .

(function() {
    $(document).on('click', '.toggle-window', function(e) {
        e.preventDefault();
        var panel = $(this).parent().parent();
        var messages_list = panel.find('.messages-list');

        panel.find('.panel-body').toggle();
        panel.attr('class', 'panel panel-default');

        if (panel.find('.panel-body').is(':visible')) {
            var height = messages_list[0].scrollHeight;
            messages_list.scrollTop(height);
        }
    });
})();
