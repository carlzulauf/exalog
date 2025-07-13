module ApplicationHelper
  def inline_svg(svg_name)
    File.read(Rails.root.join("app", "assets", "images", "#{svg_name}.svg")).html_safe
  end

  def current_theme
    return cookies["theme"] if cookies["theme"].present?

    "dark-theme"
  end

  def body_tag(&)
    classes = [current_theme, *Array.wrap(@body_classes)]
    controllers = Array.wrap(@body_controllers)
    options = { class: classes }
    options[:data] = { controller: controllers.join(" ") } if controllers.any?
    content_tag(:body, **options, &)
  end

  def add_body_class(name)
    @body_classes ||= []
    @body_classes << name
  end
  # js controllers that are full page or exclusive
  def add_body_controller(name)
    @body_controllers ||= []
    @body_controllers << name
  end
end
