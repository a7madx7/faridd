class GenericsController < ApplicationController
  semantic_breadcrumb :index, :generics_path
  respond_to :js, :json, :html
  before_action :set_generic, only: [:show, :edit, :update, :destroy]

  def index
    # @generics = Generic.all.sort { |a, b| a.name <=> b.name }
    @generics = Generic.all.order(:name).paginate(per_page: 40, page: params[:page]).order(:name)
  end

  def show

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

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_generic
    @generic = Generic.where(id: params[:id]).first
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def generic_params
    params.require(:generic).permit(:name, :image_url, :invented_at)
  end
end
