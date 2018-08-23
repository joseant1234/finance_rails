$(document).on 'change', '.client-select-income' , ()->
  client_id = $(this).val()
  action = $('#client_information_link').attr('href')
  if client_id and action
    $.get action, { client_id: client_id}, null, 'script'


$(document).on 'change', '.state-select-income', ()->
  state = $(this).val()
  if state and state == 'paid'
    console.log state
    $('.transaction-at-wrapper-income').fadeIn()
  else if state
    $('.transaction-at-wrapper-income').fadeOut()