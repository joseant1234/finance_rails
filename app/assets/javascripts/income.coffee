$(document).on 'change', '.client-select-income' , ()->
  client_id = $(this).val()
  action = $('#client_information_link').attr('href')
  if client_id and action
    $.get action, { client_id: client_id}, null, 'script'