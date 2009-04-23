// Making facebox all links with 'protected=true'
jQuery(document).ready( function() {
  $("a[rel='facebox']").facebox();
  $(document).bind('reveal.facebox', function() { $("a[protected='true']").facebox(); }) 
})
