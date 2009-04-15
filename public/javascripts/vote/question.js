jQuery(document).ready(function(){
  $("a.vote_link").click(function(){
    $.ajax({
      type : 'post' ,
      url : $(this).attr('href') ,
      dataType: "script"      
    })
    return false;
  }) 
})
