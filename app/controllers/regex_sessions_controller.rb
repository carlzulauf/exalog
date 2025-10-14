class RegexSessionsController < ApplicationController
  def index
    @regex_session = RegexSession.new
  end

  def show
    @regex_session = RegexSession.find(params[:id])
    render :index
  end

  def create
    @regex_session = RegexSession.new(regex_session_params).execute

    if @regex_session.persisted?
      redirect_to regex_session_url(@regex_session)
    else
      respond_to do |format|
        format.turbo_stream
        format.html { render :index }
      end
    end
  end

  def update
    @regex_session = RegexSession.find(params[:id])
    @regex_session.assign_attributes(regex_session_params)
    @regex_session.execute

    respond_to do |format|
      format.turbo_stream { render :create }
      format.html { render :index }
    end
  end

  private

  def regex_session_params
    params.require(:regex_session).permit(
      :pattern, :haystack,
      :lines, :savemode,
      :insensitive, :extended, :multiline
    )
  end
end
