class RegexSessionsController < ApplicationController
  def index
    @regex_session = RegexSession.new
  end
end
