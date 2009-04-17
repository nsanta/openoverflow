jQuery(document).ready(function(){
  $("a.select_answer_link").click(function(){
    $.ajax({
      url : $(this).attr('href') ,
      type : 'post' ,
      dataType : 'script'
    });
    return false;
  })
})
