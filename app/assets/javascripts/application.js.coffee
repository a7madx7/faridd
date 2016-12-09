# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file. JavaScript code in this file should be added after the last require_* statement.
#
# Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
# about supported directives.
# Loads all Semantic javascripts
#= require jquery
#= require jquery_ujs
#= require jquery-readyselector
#= require semantic-ui
#= require jquery.turbolinks
#= require_tree

prepare_dropdowns = ->
  $('#country_selection').dropdown('set selected', 'eg').dropdown 'set text', 'Egypt'
  $('#country_selection .text').prepend '<i class="eg flag"> </i>'
  $('#gender_selection').dropdown('set selected', 'Male').dropdown 'set text', 'Male'
  $('#gender_selection .text').prepend '<i class="male icon"> </i>'
  $('#profession_selection').dropdown('set selected', 'pharmacist').dropdown 'set text', 'Pharmacist'
  $('#profession_selection .text').prepend '<i class="doctor icon"> </i>'
  return

prepare_seed = ->
  $('#user_email').val 'ahmad.hamdi.emara@gmail.com'
  $('#user_username').val 'a7madx7'
  $('#user_first_name').val 'Ahmad'
  $('#user_last_name').val 'Hamdi'
  $('#user_password').val '123testing'
  $('#user_password_confirmation').val '123testing'
  return

search = ->
  $('#search_box').search
    apiSettings: url: '/search?mode=all&term={query}'
    minCharacters: 3
    type: 'category'
  return

alertification = ->
  # fade out the flash message
  $('.pusher').children('.ui.message').fadeOut(5000)
  $message = $('.ui.message')
  if $message and $message.hasClass('negative')
    alertify.error($message.text())
  else if $message and $message.hasClass('positive')
    alertify.success($message.text())
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

responsive_elements = ->
  $('.ui.checkbox').checkbox()
  # todo: replace the class selector with the id selector for a more specific approach
  dropdown_effects = ['drop','horizontal flip','fade up','scale']
  rand = dropdown_effects[Math.floor(Math.random() * dropdown_effects.length)]
  $('.ui.dropdown').dropdown()
  $('.ui.pointing.dropdown').dropdown
    allowAdditions: true
    transition: "#{rand}"
    on: 'hover'
  $('.ui.ribbon.label').on 'click', ->
    $('#loader').show()
  return
assign_css = ->
  # add css classes here
ready = ->
  responsive_elements()
  search()
  sorter()
  # prepare_dropdowns();
  # prepare_seed();
  #  $sidebar = $('.ui.sidebar')
  #  $('.ui.right.item').mouseenter(-> $sidebar.sidebar('toggle'))
  alertification()
  return

$ ready

$(document).on "page:load", ready
