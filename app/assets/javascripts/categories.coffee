# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $('a.cat').on('mouseenter', ->
    $this = $(this)
    pop = $this.data('pop')
    $this.popup(
      popup: $("#category_popup_#{pop}"),
      target: $this
    ).popup('toggle')
  )

$ ->
  ready()
$(document).on('page:load', ready)