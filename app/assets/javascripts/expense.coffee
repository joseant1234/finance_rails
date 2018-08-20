# $(document).on 'keyup', '.amout-field', ()->
#   amount = $(this).val()
#   $('.igv-field').val(amount * 0.18)
#   Materialize.updateTextFields()

$(document).on 'change', '.provider-select' , ()->
  provider_id = $(this).val()
  action = $('#provider_information_link').attr('href')
  if provider_id and action
    $.get action, { provider_id: provider_id}, null, 'script'

$(document).on 'change', '.with-fee-toggle', ()->
  if $(this).prop('checked')
    $('.fees-container').fadeIn()
  else
    $('.delete-fee-link').click()
    $('.fees-container').fadeOut()

$(document).on 'change', '.payment-type-select', ()->
  payment = $(this).val()
  pay_upon_delivery = $('.upon-delivery-container')
  pay_transference = $('.transference-container')

  if payment == 'transference'
    pay_upon_delivery.fadeOut('slow')
    pay_transference.fadeIn('slow')
  else if payment == 'realized'
    pay_transference.fadeOut('slow')
    pay_upon_delivery.fadeOut('slow')
  else if payment == 'upon_delivery'
    pay_transference.fadeOut('slow')
    pay_upon_delivery.fadeIn('slow')

$(document).on 'cocoon:after-insert', '#fees', ()->
  init_datepicker()

init_datepicker = ->
  $('.datepicker').pickadate
    closeOnSelect: true
    format: 'yyyy-mm-dd'
    formatSubmit: 'yyyy-mm-dd'
    hiddenName: true
    selectYears: 15
    selectMonths: true