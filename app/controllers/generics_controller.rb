class GenericsController < ApplicationController
  def index
    # @generics = Generic.all.sort { |a, b| a.name <=> b.name }
    @generics = Generic.all.order(:name).paginate(per_page: 40, page: params[:page]).order(:name)
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def new
  end

  def create
  end
end
