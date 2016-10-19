# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
has_errors = ->
  $title = $('#new_article_title')
  $content = $('#new_article_content')
  if $title.val().empty() or $content.val().empty()
    return true
  else
    return false
create_new_article = ->
  $submit = $('#create_new_article_button')
  $submit.children('.ui.button').html("<i class='edit icon'></i>Posting...")
  if has_errors()
    # show error messages
  else
    this.parentNode.parentNode.submit()


$(-> $('#create_new_article_button').click -> create_new_article())