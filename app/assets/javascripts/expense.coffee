$(document).on 'turbolinks:load', ()->
  data = {}
  $('#categories_expense p').each (element)->
    obj = {}
    obj[$(this).text()] = null
    Object.assign data, obj
  $('input.autocomplete-categories-expenses').autocomplete
    data: data

$(document).on 'change', '.provider-select' , ()->
  provider_id = $(this).val()
  action = $('#provider_information_link').attr('href')
  if provider_id and action
    $.get action, { provider_id: provider_id}, null, 'script'

$(document).on 'change', '.team-select', ()->
  team_id = $(this).val()
  action = $('#collaborators_information_link').attr('href')
  if team_id and action
    $.get action, { team_id: team_id}, null, 'script'

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

$(document).on 'click', '.btn-pay-expense', (ev)->
  ev.preventDefault()
  amount = $(this).data 'amount'
  action = $(this).data 'form-action'

  $('#errors').addClass 'hidden'
  $("small[id*='_error']").html ''
  $("input, textarea").removeClass 'invalid'

  $('#modalPayExpense').modal 'open'
  if amount && action
    $('.amount-expense').val amount
    $('#modalPayExpense form').attr 'action', action
    Materialize.updateTextFields()

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