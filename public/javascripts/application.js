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
  if ($("#search").val().replace(" ", "") == "") {
    $("#search").value = "Bordeaux, 2008";
    $("#search").addClass("is_blank");
  }
  $("#search").focus(function() {
    if($(this).hasClass("is_blank")) {
      this.value  = '';
      $(this).removeClass("is_blank");
    }
    $(this).blur(function() {
      if(this.value == '') {
        this.value = "Bordeaux, 2008";
        $(this).addClass("is_blank");
      }
      else if(this.value != "Bordeaux, 2008") {
        $(this).removeClass("is_blank");
      }
    });
  });

});