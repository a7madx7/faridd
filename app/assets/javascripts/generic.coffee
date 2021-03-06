# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  controller = window.location.pathname
  regex = new RegExp("^/generics")
  return false unless regex.test(controller)
  $loader = $('#loader')
  $('.fluid.card a').on 'click', ->
    $loader.show()
  alertify.success('Generics loaded')
  $loader.hide()

$ ready
$(document).on 'page:load', ready