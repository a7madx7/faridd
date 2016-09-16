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
#= require turbolinks
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
  $('#user_password').val '#1forever'
  $('#user_password_confirmation').val '#1forever'
  return

search = ->
  $('#search_box').search
    apiSettings: url: '/search?term={query}'
    minCharacters: 3
    type: 'category'

ready = ->
  $('.ui.checkbox').checkbox()
  # todo: replace the class selector with the id selector for a more specific approach
  $('.ui.dropdown').dropdown
    allowAdditions: true
    transition: 'drop'
  search()
  $('table').tablesort()
  maxHeight = -1
  cards = $('.drugs.index .ui.card')
  cards.each ->
    maxHeight = if maxHeight > $(this).height() then maxHeight else $(this).height()
    return
  cards.each ->
    $(this).height maxHeight
    return
  # prepare_dropdowns();
  # prepare_seed();
  return

$(document).on("page:change", ->
  ready);
$(ready)
#$('#search_input').on('keypress', search)