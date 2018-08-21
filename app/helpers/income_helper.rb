module IncomeHelper

  def color_state_of_income(income)
    return 'amber' if income.pending?
    return 'green' if income.paid?
    return 'red' if income.cancelled?
  end

  def print_color_state_of_income
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