// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(function() {

  // Star Ratings Behaviour
  $("ul.star_rating li a").click(function() {
    $("#review_rating_id").val($(this).parent().attr("class").replace("stars_", "").replace("current", "").replace(" ", ""));
    $("ul.star_rating li").removeClass("current");
    $(this).parent().addClass("current");
  });

});
