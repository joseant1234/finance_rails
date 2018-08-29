module ApplicationHelper

  def li_paint_slider(text, path, option)
    if controller.controller_name == option
      link_css_class = 'white custom-color-text'
    else
      link_css_class = 'white-text'
    end

    link_to text, path, class: "collection-item option-item white-text #{link_css_class}"
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction, :term => params[:term] }, {:class => css_class, remote: true}
  end

  def sortable_with_multiple_filter(column, title = nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    content_tag(:a, title, href: '#', data: {sort: column, direction: direction}, class: "#{css_class} send-form-with-sortable", remote: true)
  end

  def print_color_status
    content_tag(:div, class: 'top-space') do
      content_tag(:div,nil, class: 'color-state white accent-1 border-space')+
      content_tag(:span, 'Active', class: 'little-left-space')+

      content_tag(:div,nil, class: 'color-state grey lighten-2 little-left-space')+
      content_tag(:span, 'Inactive', class: 'little-left-space')

    end
  end

  def color_tr(object)
    object.desactive? ? 'grey lighten-2' : ''
  end

  def link_status(object)
    return link_to_desactive(object) if object.active?
    return link_to_active(object)
  end

  def link_to_desactive(object)
    if object.class.name == 'Site' && object.featured?
      content_tag(:i,'delete', class: 'material-icons grey-text')
    else
      content_tag(:a, href: '#',
        'data-url': Rails.application.routes.url_helpers.send("status_#{object.class.name.underscore}_path",id: object.id),
        'data-confirmation-text': object.try(:name) || object.title, 'data-option-method': 'put',
        class: 'open-modal-confirmation red-text') do
        content_tag(:i,'delete', class: 'material-icons')
      end
    end
  end

  def link_to_active(object)
    content_tag(:a, href: '#',
      'data-url': Rails.application.routes.url_helpers.send("status_#{object.class.name.underscore}_path",id: object.id),
      'data-confirmation-text': object.try(:name) || object.title, 'data-option-method': 'put', 'data-option-text': 'active',
      class: 'open-modal-confirmation black-text') do
      content_tag(:i,'rotate_left', class: 'material-icons')
    end
  end

  def class_enum_for_select(class_name, enum_name)
    class_name.constantize.send(enum_name.pluralize).keys.map {|k| [k.humanize, k]}
  end

  def print_zoom_image(src,height="100%",width="100%")
    image_tag(src, height: height, width: width, class: 'materialboxed')+
    content_tag(:div, class: 'center', style: "width: #{width}") do
      content_tag(:small, '(click to zoom)', class: 'bold')
    end
  end

  def param_or_resource(param,parent,resource,attr)
    return param if param.present?
    return resource.send(parent).send(attr) if resource.send(parent).present?
  end

end
