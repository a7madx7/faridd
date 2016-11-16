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

data_init = ->
  $category_drop_down = $('#category')
  alertify.success($category_drop_down.html())
  $category_drop_down.dropdown(
    apiSettings: url: "/search?mode=category&term={query}"
    allowAdditions: true
    maxSelections: 5
  )
  $unit_drop_down = $('#unit')
  $unit_drop_down.dropdown(
    apiSettings: url: "/search?mode=unit&term={query}"
  )
  $company_drop_down = $('#company')
  $company_drop_down.dropdown(
    apiSettings: url: "/search?mode=company&term={query}"
  )
  return
  
sorter = ->
  $('table').tablesort()
  maxHeight = -1
  cards = $('.drugs.index .ui.card')
  cards.each ->
    maxHeight = if maxHeight > $(this).height() then maxHeight else $(this).height()
  cards.each ->
    $(this).height maxHeight
  return

drugs_ready = ->
  $('.ui.rating').rating( { initialRating: 3, maxRating: 5 } )
  #  $('#drug_show_card').hide().transition('fly left')
  $('.ui.four.column.grid').hide().transition('fly left')
  sorter()
  #  loader_ajax()
  data_init()

$ ->
  drugs_ready()

$(document).on('page:change', drugs_ready)
