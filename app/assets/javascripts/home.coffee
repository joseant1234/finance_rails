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

$(document).on 'click', '.pagination-from-table .pagination a', ->
  $(this).closest('.pagination').html('Cargando ...')
  $.get this.href, null, null, 'script'
  false

$(document).on 'change', '.send-filter', ()->
  # $(this).closest('form').submit()
  # $('#filter_button').trigger('click')
  Rails.fire(document.getElementById('search_form'), 'submit')

$(document).on 'change', '.source-select', ()->
  source = $(this).val()
  if source && source == 'direct'
    $('.subtotal-label').text 'Total'
    $('.fields-with-invoice').fadeOut()
    $('.fields-with-direct').fadeIn()
  else if source
    $('.subtotal-label').text 'Subtotal'
    $('.fields-with-invoice').fadeIn()
    $('.fields-with-direct').fadeOut()

$(document).on 'click', '.send-form-with-sortable', (ev)->
  ev.preventDefault()
  sort_column = $(this).data 'sort'
  direction_column = $(this).data 'direction'
  if sort_column && direction_column
    $('#sort_hidden').val sort_column
    $('#direction_hidden').val direction_column
    Rails.fire(document.getElementById('search_form'), 'submit')

init_datepicker = ->
  $('.datepicker').pickadate
    closeOnSelect: true
    format: 'yyyy-mm-dd'
    formatSubmit: 'yyyy-mm-dd'
    hiddenName: true
    selectYears: 15
    selectMonths: true