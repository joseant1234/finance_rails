$(document).on 'change', '.client-select-income' , ()->
  client_id = $(this).val()
  action = $('#client_information_link').attr('href')
  if client_id and action
    $.get action, { client_id: client_id}, null, 'script'


$(document).on 'change', '.state-select-income', ()->
  state = $(this).val()
  if state and state == 'paid'
    $('.transaction-at-wrapper-income').fadeIn()
  else if state
    $('.transaction-at-wrapper-income').fadeOut()

$(document).on 'keyup', '.subtotal-field,.igv-field', ()->
  subtotal = parseFloat($('.subtotal-field').val())
  igv = parseFloat($('.igv-field').val()/100)
  $('.igv-amount-field').val((subtotal * igv).toFixed(2))
  igv_amount = parseFloat($('.igv-amount-field').val())
  $('.total-field').val((subtotal + igv_amount).toFixed(2))
  Materialize.updateTextFields()