class RegexesController < ApplicationController
  def show
    @entries = RegexCheatSheet.entries(name: params[:id])
  end
end
