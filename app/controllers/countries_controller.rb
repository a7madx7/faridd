class CountriesController < ApplicationController
  before_action :set_country, only: [:show, :index]
  def show

  end
  def index

  end

  private

  def set_country
    params.require(:country).permit(:id)
  end
end
