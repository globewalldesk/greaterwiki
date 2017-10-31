var ready = function() {

$(".user_title").click(showEditUserTitle);
$(".user_desc").click(showEditUserDesc);

function showEditUserTitle() {
  $(".user_title").hide();
  $("#edit_user_title").show();
  var field = $(".title_input");
  field.focus();
  // Move cursor to end of string.
  var temp = field.val();
  field.val('');
  field.val(temp);
}

function showEditUserDesc() {
  $(".user_desc").hide();
  $("#edit_user_desc").show();
  var field = $(".desc_input");
  field.focus();
  // Move cursor to end of string.
  var temp = field.val();
  field.val('');
  field.val(temp);
}


};
$(document).ready(ready);
$(document).on('page:load', ready);
