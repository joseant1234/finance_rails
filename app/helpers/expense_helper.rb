module ExpenseHelper

  def color_state_of_expense(expense)
    return 'amber' if expense.pending?
    return 'green' if expense.paid?
    return 'red' if expense.overdued?
  end

  def print_color_state_of_expense
    content_tag(:div, class: 'top-space') do
      content_tag(:div,nil, class: 'color-state amber border-space')+
      content_tag(:span, 'Pending', class: 'little-left-space')+

      content_tag(:div,nil, class: 'color-state green little-left-space')+
      content_tag(:span, 'Paid', class: 'little-left-space') +

      content_tag(:div,nil, class: 'color-state red little-left-space')+
      content_tag(:span, 'Overdued', class: 'little-left-space')
    end
  end

  def link_to_pay(expense)
    return link_to "<i class='material-icons'>monetization_on</i>".html_safe, expense_fees_path(expense), class: "green-text" if expense.with_fee == true
    return content_tag(:a,"<i class='material-icons'>monetization_on</i>".html_safe, href: '', class: "green-text btn-pay-expense", data: { amount: expense.amount_decimal, form_action: pay_expense_path(expense) })
  end

end