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

responsive_elements = ->
  $('.ui.checkbox').checkbox()
  # todo: replace the class selector with the id selector for a more specific approach
  dropdown_effects = ['drop','horizontal flip','fade up','scale']
  rand = dropdown_effects[Math.floor(Math.random() * dropdown_effects.length)]
  $('.ui.pointing.dropdown').dropdown
    allowAdditions: true
    transition: "#{rand}"
    on: 'hover'
  return

ready = ->
  controller = window.location.pathname
  regex = new RegExp("^/articles")
  return false unless regex.test(controller)
  responsive_elements()
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

$ ready
$(document).on 'page:load', ready