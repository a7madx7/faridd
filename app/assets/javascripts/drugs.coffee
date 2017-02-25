# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
sorter = ->
  $('table').tablesort()
  maxHeight = -1
  cards = $('.ui.card')
  cards.each ->
    maxHeight = if maxHeight > $(this).height() then maxHeight else $(this).height()
  cards.each ->
    $(this).height maxHeight
  return

responsive_elements = ->
  #  $('.ui.checkbox').checkbox()
  # todo: replace the class selector with the id selector for a more specific approach
  dropdown_effects = ['drop','horizontal flip','fade up','scale']
  rand = dropdown_effects[Math.floor(Math.random() * dropdown_effects.length)]
  $('.ui.pointing.dropdown').dropdown
    allowAdditions: true
    transition: "#{rand}"
    on: 'hover'
  return

data_init = ->
  $category_drop_down = $('#category')
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
  cards = $('.ui.card')
  cards.each ->
    maxHeight = if maxHeight > $(this).height() then maxHeight else $(this).height()
  cards.each ->
    $(this).height maxHeight
  return

ready = ->
  controller = window.location.pathname
  regex = new RegExp("^/drugs")
  action_regex = new RegExp("new$")
  return false unless regex.test(controller)
  $loader = $('#loader')
  $loader.show()
  try
    $rating = $('.ui.rating')
    if $rating.length
      alertify.message($rating.html())
      $rating.rating( { initialRating: 3, maxRating: 5 } )
    #  $('#drug_show_card').hide().transition('fly left')
    $('.ui.four.column.grid').hide().transition('fly left')
    sorter()
    responsive_elements()
    #  loader_ajax()
    data_init()
  catch error
    console.log(error)
  finally
    $loader.hide()
    alertify.success("Drugs loaded!") unless action_regex.test(controller)


$ ready

$(document).on 'page:load', ready
