// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.uk
//= require jquery_nested_form
//= require_tree .

$(function() {
  urlParams = function Pasr(url){
    var results = new RegExp('[\\?&]' + url + '=([^&#]*)').exec(window.location.href);
    if (results) { return results[1] } else {return 0}
  }

  if (urlParams("url")) {
    $.getScript(unescape(urlParams("url")))
  }

  $('.carousel').carousel({ interval: false });
  $('.basic-cart').popover({ html: true, trigger: 'hover', placement: 'left' });

  $(document).on("focus", "[data-behaviour~='datepicker']", function(e){
    $(this).datepicker({"format": "yyyy-mm-dd", "weekStart": 1, "autoclose": true});
  });

  $('a[disabled]').click(function(){ return false })

});
