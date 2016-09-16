# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $('#drug_show_card').hide().transition('fly left')
  $('table').tablesort()
  maxHeight = -1
  cards = $('.drugs.index .ui.card')
  cards.each ->
    maxHeight = if maxHeight > $(this).height() then maxHeight else $(this).height()
    return
  cards.each ->
    $(this).height maxHeight
    return


$(ready())
$.on('page:change', ready())