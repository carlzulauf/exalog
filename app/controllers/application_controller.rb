class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern
  def regex_domain?
    ["localhost", "regex.mrks.io"].member?(request.host)
  end
  helper_method :regex_domain?
end
