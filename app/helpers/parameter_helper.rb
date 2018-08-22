module ParameterHelper

  def text_rate_of_change
    content_tag(:small,"(Rate of chage: #{get_rate_of_change})",class: 'block')
  end

  def get_rate_of_change
    @get_rate_of_change ||= Parameter.rate_of_change.last.value
  end
end