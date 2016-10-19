# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
loader_ajax = ->
  $loader = $('#loader')
  $loader.hide()
  $(document).ajaxStart( ->
    $loader.hide()
    $loader.fadeIn('slow'))
  .ajaxStop( ->
    $loader.hide()
    sorter())
  return

ready = ->
  $('.ui.rating').rating( { initialRating: 3, maxRating: 5 } )
  $('#drug_show_card').hide().transition('fly left')
  $('.ui.four.column.grid').hide().transition('fly left')
  $('table').tablesort()
  maxHeight = -1
  cards = $('.drugs.index .ui.card')
  if cards
    cards.each ->
    maxHeight = if maxHeight > $(this).height() then maxHeight else $(this).height()
    return
  cards.each ->
    $(this).height maxHeight
    return
  loader_ajax()


$(ready)
$(document).on('page:change', ready)

update_drug_modal_content = ->
  $('#drug_modal_content').html("<%= j(render 'drugs/categories_ul', cats: @drug.categories) %>")