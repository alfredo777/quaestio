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
//= require cocoon
//= require bootstrap-sprockets
//= require bootstrap/scrollspy
//= require bootstrap-select
//= require bootstrap/alert
//= require bootstrap/modal
//= require bootstrap/dropdown
//= require handlebars
//= require highcharts
//= require soundmanager2
//= require soundmanager2-jsmin
//= require soundmanager2-nodebug-jsmin
//= require soundmanager2-nodebug
//= require highcharts/highcharts-more
//= require turbolinks
//= require_tree .

function readURL(input,targetDIV) {

    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('#'+targetDIV).append('src', e.target.result);
        }

        reader.readAsDataURL(input.files[0]);
    }
}

function readNAME(input,targetDIV) {
    if (input.files && input.files[0]){       
            $('#'+targetDIV).html('<h4><i class="fa fa-file-text" aria-hidden="true"></i> '+input.files[0].name+'</h4>');
    }       
}

function SliderMYIMG(div, img, animate){
  $('#'+div).animateCss(animate);

  setTimeout(function(){
    $('#'+div).animateCss('zoomInUp');
    $('#'+div).css({'background':'url'+"("+img+")",
      "background-size": "100%"
    });

  },700);
}


$.fn.extend({
    animateCss: function (animationName) {
        var animationEnd = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend';
        this.addClass('animated ' + animationName).one(animationEnd, function() {
            $(this).removeClass('animated ' + animationName);
        });
    }
});



