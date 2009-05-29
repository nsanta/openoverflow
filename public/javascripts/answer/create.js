jQuery(document).ready(function(){
  $("#answer_new_form").submit(function(){
    $.ajax({
      url  : $("#answer_new_form").attr('action'),
      data : {body : $("textarea[name='body']").attr('value')} ,
      dataType: "script",
      type : 'post',
      success: function(){
        $.facebox.close(); 
      }
    });
    return false;
  })
})
