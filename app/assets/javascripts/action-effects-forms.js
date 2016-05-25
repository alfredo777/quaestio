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
 $('#'+siguID).show();
 $('#siguiente').data('actual', sigu.attr('id'));

}