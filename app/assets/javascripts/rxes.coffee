# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
add_drugs = ->
  $drug_selection = $('.ui.drug.dropdown')
  $drug_selection.dropdown
    apiSettings: url: '/search?mode=drugs&term={query}'
    allowAdditions: true
    maxSelections: 33
    onChange: (value, text, $selection)->
      new_item = '<div class="item">'
      new_item += "<span class='ui teal circular label'>"
      new_item += "#{$('.list .item').length + 1}"
      new_item += '</span>&nbsp;'
      new_item += '<img class="ui avatar image" src="https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xta1/v/t1.0-1/c0.0.240.240/p240x240/14495443_1804111073167090_8812469227517466532_n.jpg?oh=8f23282bac9944e5b48f2899742822ab&oe=589B1D7B&__gda__=1487427159_33cb0d2b066d87e2f4e4b30e39c74880">'
      new_item += '<div class="content">'
      new_item += "<a class='header'>#{$selection}</a>"
      new_item += '<div class="description">was just added to <a><b>The prescription</b></a> just now.</div>'
      new_item += '</div>'
      new_item += '</div>'
      alertify.success("Added #{$selection} successfully to your online faridd prescription!")
      $('.new_prescription').append(new_item)

  return

add_diagnosis = ->
  $diagnosis_selection = $('.ui.diagnosis.dropdown')
  $diagnosis_selection.dropdown
    apiSettings: url: '/search?mode=diagnosis&term={query}'
    allowAdditions: true
    maxSelections: 33
    onChange: (value, text, $selection)->
      alertify.success("Selected #{$selection} as your diagnosis!")
      $(this).parents('.field').addClass('hidden').siblings('#prescription_select').removeClass('hidden')


  return

responsive_elements = ->
  # todo: replace the class selector with the id selector for a more specific approach
  dropdown_effects = ['drop','horizontal flip','fade up','scale']
  rand = dropdown_effects[Math.floor(Math.random() * dropdown_effects.length)]
  $('.ui.dropdown').dropdown
    allowAdditions: true
    transition: "#{rand}"
    fullTextSearch: true

  return

next_button_click = ($this) ->
  if $this.siblings('input').val() and $this.siblings('input').val().length > 6
    $this.parents('.field').addClass('hidden').siblings('.field').first().removeClass('hidden')
    $('.active.step').removeClass('active').next('.step').addClass('active')
  else
    alertify.error('Patient name or social security number should be more than 6 characters long!')
    $diagnosis_selection = $('#diagnosis_select')
    $diagnosis_selection.dropdown
      onChange: (value,  text,  $selection) ->
        if value == '-1'
          alertify.error('You must choose a reasonable diagnosis first')
          return
        alertify.success('Added the diagnosis successfully!')
        $('.active.step').removeClass('active').next('.step').addClass('active')

steps = ->
  $('.next.button').click ->
    $this = $(this)
    next_button_click($this)

ready = ->
  controller = window.location.pathname
  regex = new RegExp("^/rxes")
  return false unless regex.test(controller)
  responsive_elements()
  add_drugs()
  add_diagnosis()
  steps()
  return

$ ready
$(document).on "page:load", ready
