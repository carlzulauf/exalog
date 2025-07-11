module ApplicationHelper
  def inline_svg(svg_name)
    File.read(Rails.root.join("app", "assets", "images", "#{svg_name}.svg")).html_safe
  end

  def current_theme
    return cookies["theme"] if cookies["theme"].present?

    "dark-theme"
  end
end
