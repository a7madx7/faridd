class GenericsController < ApplicationController
  semantic_breadcrumb :index, :generics_path
  respond_to :js, :json, :html
  before_action :set_generic, only: [:show, :edit, :update, :destroy]
  before_action :get_wiki, only: [:show]

  def new
    @generic = Generic.new
  end

  def index
    # @generics = Generic.all.sort { |a, b| a.name <=> b.name }
    @generics = Generic.all.paginate(per_page: 40, page: params[:page]).order(:name)
  end

  def show
    @generic.view_count += 1
    @generic.save
    # if the user is using an older slug
    if request.path != generic_path(@generic)
      redirect_to @generic, status: :moved_permanently
    end

    # if we have three videos they are enough, if not search youtube
    unless @generic&.youtube_videos.count > 3
      begin
        @generic.youtube
      rescue
        not_found
      end
    end
  end
  def update

  end

  def edit

  end

  def destroy
    @generic.destroy
    respond_to do |format|
      format.html { redirect_to generics_url, notice: 'Generic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def create
    @generic = Generic.new(generic_params)

    respond_to do |format|
      if @generic.save(generic_params)
        format.html { redirect_to @generic, notice: 'Generic has been successfully created!' }
        format.json { render :show, status: :ok, location: @generic }
      else
        format.html { render :new }
        format.json { render json: @generic.errors, status: :unprocessable_entity }
      end
    end

  end

  def recent
    @generics = Generic.recent.paginate(per_page: 33, page: params[:page])
  end
  def trending
    @generics = Generic.trending.paginate(per_page: 33, page: params[:page])
  end
  def popular
    @generics = Generic.popular.paginate(per_page: 20, page: params[:page])
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_generic
    @generic = Generic.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def generic_params
    params.require(:generic).permit(:name, :image_url, :invented_at, :country)
  end

  def get_wiki
    @generic.wiki('wikipedia_page_url')
  end
end
