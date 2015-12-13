// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap/dist/js/bootstrap.min
//= require bootstrap-switch/dist/js/bootstrap-switch.min
//= require select2/select2.min
//= require_tree .


$(document).on('page:change', function() {
  $('[data-toggle="tooltip"]').tooltip();
  $('[data-name="switch"]').bootstrapSwitch({
  	size: 'mini'
  });
  $('[data-name="select2"]').select2({ width: 'resolve' });
})