jQuery(document).ready(function(){
  $("#answer_new_form").submit(function(){
    $.ajax({
      url  : '/questions/2/answers.js',
      data : {body : $('#answer_new_form > #body').attr('value')} ,
      dataType: "script",
      type : 'post'
    });
    return false;
  })
})
