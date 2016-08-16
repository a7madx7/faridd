class GenericsController < ApplicationController
  def index
    # @generics = Generic.all.sort { |a, b| a.name <=> b.name }
    @generics = Generic.paginate(per_page: 40, page: params[:page])#.sort { |a, b| a.name <=> b.name }
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
