# for mostly static pages
class PagesController < ApplicationController
  def show
    render params[:id]
  end

  def index
    Rails.logger.warn "host: #{request.host}"
    case request.host
    when "regex.mrks.io"
      @regex_session = RegexSession.new
      render "regex_sessions/index"
    end
  end
end
