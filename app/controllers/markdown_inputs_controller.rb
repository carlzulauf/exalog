class MarkdownInputsController < ApplicationController
  def new
    @markdown_input = MarkdownInput.new
  end

  def create
    @markdown_input = MarkdownInput.new(markdown_input_params)
    respond_to do |format|
      format.turbo_stream
      format.html { render :new }
     end
  end

  private

  def markdown_input_params
    params.require(:markdown_input).permit(:body)
  end
end
