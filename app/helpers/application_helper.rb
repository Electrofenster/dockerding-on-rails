module ApplicationHelper
  def glyph(*names)
    content_tag :i, nil, class: names.map{|name| "glyphicon glyphicon-#{name.to_s.gsub('_','-')}" }
  end

  def bootstrap_class_for flash_type
    case flash_type
      when 'success'
        "alert-success" # Green
      when 'error'
        "alert-danger" # Red
      when 'alert'
        "alert-warning" # Yellow
      when 'notice'
        "alert-info" # Blue
      else
        flash_type.to_s
    end
  end

end
