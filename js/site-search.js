$("#site-search-query").myautocomplete({
  source: function(request, response) {
    if ($.trim(request.term).length < 1) {
      return false;
    }
    $.ajax({
      type: "GET",
      data: request,
      url: "http://search.groonga.org/autocomplete",
      dataType: "json",
      success: function(data) {
        response(data);
      }
    });
  },
  delay: 10,
  minLength: 1
});
