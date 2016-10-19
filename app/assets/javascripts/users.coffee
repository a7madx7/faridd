# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
prepare_form = ->
  $('.ui.popup').popup()
  $("#user_email").popup({ popup: "#email_popup" })
  $('#user_first_name').popup({ popup: "#first_name_popup" })
  $("#user_last_name").popup({ popup: "#last_name_popup" })
  $("#user_gender").popup({ popup: ".ui.popup" })
  $("#user_country").popup({ popup: ".ui.popup" })
  $("#user_profession").popup({ popup: ".ui.popup" })
$(prepare_form)
