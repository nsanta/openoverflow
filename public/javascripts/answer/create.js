jQuery(document).ready(function(){
  $("#answer_new_form").submit(function(){
    $.ajax({
      url  : $("#answer_new_form").attr('action'),
      data : {body : $('#answer_new_form > #body').attr('value')} ,
      dataType: "script",
      type : 'post'
    });
    return false;
  })
})
