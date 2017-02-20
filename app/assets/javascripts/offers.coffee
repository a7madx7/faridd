# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
has_errors = ->
  $drug = $('#offer_drug_id')
  $amount = $('#offer_amount')
  $discount = $('#offer_discount')

  return true if $drug.val().empty or $drug.val().length <= 0
  return true if $amount.val().empty or $amount.val().length <= 0
  return true if $discount.val().empty or $discount.val().length <= 0
  false

ready = ->
  controller = window.location.pathname
  regex = new RegExp("^/trade_center")
  # to prevent this ready method from firing on another rails contoller
  return false unless regex.test(controller)
  $submit = $('#offer_submit_button')
  $submit.click ->
    if has_errors()
      alertify.error("Your offer didn't meet faridd's standards")
    else
      $(this).html("<i class='dollar icon'></i> Making money baby...")
      $('.ui.stacked.form.segment').submit()
      $(this).prop('enabled', false)

  $('input').change -> $submit.prop('enabled', true)


$ ready
$(document).on('page:load', ready)
