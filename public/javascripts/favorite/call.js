$(document).ready(function(){
 $('a.favorite_link').click(function(){
   $.ajax({url : $(this).attr('href'),
           type : $(this).attr('rel'),
           dataType: "script"
         });
   return false;
 });  
})

