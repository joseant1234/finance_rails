module ExpenseHelper

  def color_state_of_expense(expense)
    return 'amber' if expense.pending?
    return 'green' if expense.paid?
    return 'red' if expense.expirated?
  end

  def print_color_state_of_expense
    content_tag(:div, class: 'top-space') do
      content_tag(:div,nil, class: 'color-state amber border-space')+
      content_tag(:span, 'Pending', class: 'little-left-space')+

      content_tag(:div,nil, class: 'color-state green little-left-space')+
      content_tag(:span, 'Paid', class: 'little-left-space') +

      content_tag(:div,nil, class: 'color-state red little-left-space')+
      content_tag(:span, 'Cancelled', class: 'little-left-space')
    end
  end

end