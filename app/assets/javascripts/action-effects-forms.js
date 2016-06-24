function opPaginateForm() {
  $('.insturcciones').slideToggle('slow');
  setTimeout(function(){
    $('.paginar').slideToggle('fast');
  }, 1200);
}

function pagNext(){
 var siG = $('#siguiente').data('actual');
 var acT = $('#'+siG).hide();
 var sigu = $('#'+siG).next('.pagina');
 var siguID = sigu.attr('id');
 var parsProgress = 0;
 var lengthcV = $('#pbar').width();
 var lengthcVX = $('.progress').width();
 var cpL = $('.pagina').length; 
 var paseXCV = $('#'+siG+' .table tbody ').children(".trx");
 $.each(paseXCV, function(index, item){
  var TdX = $(item).children('td');
   $.each(TdX, function(index, itemx){
     /*console.log(itemx);*/
     var TDRX = $(itemx).children("input.pase");
     /*console.log(TDRX);*/
     var check = $(TDRX).prop("checked");
     if(check == true){
      var paseNMX = $(TDRX).data('page');
      paseNMX = Math.round(paseNMX);
      var pages = $('.pagina');
       $.each(pages, function(index, itemxx){
          var findPage = index + 1;

          if(findPage == paseNMX){
            var newxTid =$(itemxx).attr('id');
            siguID = newxTid;
            var actnewxTid = lengthcVX / cpL;
            var Calculus = index - 1 
            lengthcV = actnewxTid * Calculus;

          }
       });
     }
   });
 });
 console.log(paseXCV);
 if(siguID == null){
  $('#siguiente').hide();
  $('#envio').show();
  $('#finish').show();
 }
 
 var totale = lengthcVX / cpL;
 var intporceto =  parseInt((lengthcV/lengthcVX)* 100);
  if(intporceto == 2){
    $('#pbar').width(totale);
    porceT =  parseInt((totale/lengthcVX)* 100);
    $('#pbar').html(porceT+'%');
  }else{
    totale = lengthcV + totale;
    $('#pbar').width(totale);
    porceT =  parseInt((totale/lengthcVX)* 100);
    $('#pbar').html(porceT+'%');
  }

  

 $('#'+siguID).show();
 $('#siguiente').data('actual', siguID);
}

function IndexIntroForm(){
var exacTTT = $('.preguntaz');
 $.each(exacTTT, function(index, itemx){
  var sucIDX = index  + 1;
  var chilDX = $(itemx).children(".number");
  $(chilDX).html('<h1>'+sucIDX+'</h1>');
 });
}

function RemoveItem(){
  $('.remove').click(function(){
    setTimeout(function(){
      var OOld_alert = window.alert, confirm_alert = this.confirm;
      console.log(OOld_alert);
      console.log(confirm_alert);
      if(confirm_alert){
        var exacTTT = $('.preguntaz');
         $.each(exacTTT, function(index, itemx){
          var sucIDX = index  + 1;
          var chilDX = $(itemx).children(".number");
          $(chilDX).html('<h1>'+sucIDX+'</h1>');
         });
      }
    },50);    
  });
}

