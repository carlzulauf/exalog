class RegexSessionsController < ApplicationController
  def index
    @regex_session = RegexSession.new
  end

  def create
    @regex_session = RegexSession.new(regex_session_params)
    respond_to do |format|
      format.turbo_stream
      format.html { render :index }
    end
  end

  private

  def regex_session_params
    params.require(:regex_session).permit(:pattern, :haystack, :lines, :insensitive, :extended, :multiline)
  end
end
