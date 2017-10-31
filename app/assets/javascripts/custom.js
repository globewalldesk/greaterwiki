var ready = function() {

$(".user_title").click(showEditUserTitle);

function showEditUserTitle() {
  $("#edit_user_title").show()
  var field = $(".title_input");
  field.focus();
  // Move cursor to end of string.
  var temp = field.val();
  field.val('');
  field.val(temp);
  $(".user_title").hide();
}

};
$(document).ready(ready);
$(document).on('page:load', ready);
