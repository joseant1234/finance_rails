$(document).on 'keyup', '.amout-field', ()->
  amount = $(this).val()
  $('.igv-field').val(amount * 0.18)
  Materialize.updateTextFields()
