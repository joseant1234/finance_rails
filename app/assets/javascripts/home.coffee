$(document).on 'turbolinks:load', ()->
  $('.dropdown-button').dropdown
    hover: true
    constrainWidth: false
  $('.modal').modal()
  $('select').material_select()
  $('textarea.count-textarea').characterCounter()
  init_datepicker()

$(document).on 'click','.open-modal-confirmation',(event)->
  event.preventDefault()
  $('#modalConfirmation').modal 'open'
  url = $(this).data 'url'
  confirmation_text = $(this).data('confirmation-text')
  option_text = $(this).data('option-text')
  method = $(this).data('option-method')
  if !option_text
    option_text = 'archive'
  $("#modalConfirmation .confirmation-text").text("Are you sure to #{option_text} "+ confirmation_text + "?")
  $("#modalConfirmation").find("a").attr('href',url)
  if !method
    $("#modalConfirmation").find("a").attr('data-method','delete')
  else
    $("#modalConfirmation").find("a").attr('data-method',method)
  false;


init_datepicker = ->
  $('.datepicker').pickadate
    closeOnSelect: true
    format: 'yyyy-mm-dd'
    formatSubmit: 'yyyy-mm-dd'
    hiddenName: true
    selectYears: 15
    selectMonths: true