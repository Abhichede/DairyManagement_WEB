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
//= require rails-ujs
//= require activestorage
//= require moment
//= require bootstrap-datetimepicker
//= require jquery.validate
//= require chartkick
// require jquery
//  require turbolinks
//= require_tree .


$(function () {
    $('[data-toggle="tooltip"]').tooltip();

    $('input,select').on('keypress', function (e) {
        if (e.which === 13) {
            e.preventDefault();
            var $next = $('[tabIndex=' + (+this.tabIndex + 1) + ']');
            console.log($next.length);
            if (!$next.length) {
                $next = $('[tabIndex=1]');
                $('form').submit();
            }
            $next.focus();
        }
    });
});