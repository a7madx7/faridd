# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
has_errors = ->
  $title = $('#article_title')
  $content = $('#article_content')
  if $title.val().length <= 6 or $content.val().length <= 12
    true
  else
    false

$ ->
  $submit = $('#article_submit_button')
  $submit.click ->
    if has_errors()
      alertify.error("Your article doesn't meet faridd's article standards")
    else
      $submit = $('#article_submit_button')
      $submit.children('.ui.button').html("<i class='edit icon'></i>Posting...")
      $('.ui.stacked.segment.form').submit()
      $submit.prop('enabled', false)
  $('input').change -> $submit.prop('enabled', true)
