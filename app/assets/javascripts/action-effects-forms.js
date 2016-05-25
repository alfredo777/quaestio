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
 if(siguID == null){
  $('#siguiente').hide();
  $('#envio').show();
  $('#finish').show();
 }
 var lengthcV = $('#pbar').width();
 var lengthcVX = $('.progress').width();
 var cpL = $('.pagina').length; 
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
 $('#siguiente').data('actual', sigu.attr('id'));
}