// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(function() {

  // Star Ratings Behaviour
  $("ul.star_rating li a").click(function() {
    $("#review_rating_id").val($(this).parent().attr("class").replace("stars_", "").replace("current", "").replace(" ", ""));
    $("ul.star_rating li").removeClass("current");
    $(this).parent().addClass("current");
  });

  // Suggest search in search box
  var suggestion = "ex.: Bordeaux, 2008"
  search_field = "#search .search"
  function is_search_empty() {
    return ($(search_field).val() == "");
  }

  if (is_search_empty()) {
    $(search_field).val(suggestion)
    $(search_field).addClass("is_blank");
  }
  $(search_field).focus(function() {
    if($(this).hasClass("is_blank")) {
      $(this).val("");
      $(this).removeClass("is_blank");
    }
    $(this).blur(function() {
      if (is_search_empty()) {
        $(this).val(suggestion);
        $(this).addClass("is_blank");
      }
      else if($(this).val() != suggestion) {
        $(this).removeClass("is_blank");
      }
    });
  });

});
