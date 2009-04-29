jQuery(document).ready(function(){
  $("a.answer_new_form_link").click(function(){
    $('#answer_new_form_box').toggle();
    return false;
  })
  $('#answer_new_form_box').hide('slow');
  
})
