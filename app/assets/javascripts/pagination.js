$(function() {
  $("#articles_container").on("click", ".pagination a", function(){
    $.getScript(this.href);
    history.pushState(null, "", this.href);
    return false;
  });
});

// with help from http://stackoverflow.com/questions/13623953/how-to-implement-ajax-pagination-with-will-paginate-gem
