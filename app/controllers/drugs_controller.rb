class DrugsController < ApplicationController
  before_action :set_drug, only: [:show, :edit, :update, :destroy, :identical_drugs]
  semantic_breadcrumb :index, :drugs_path
  respond_to :html, :json, :js
  before_action :set_identical_drugs, only: [:show, :identical_drugs]

  # GET /drugs
  # GET /drugs.json
  def index
    @drugs = Drug.all.order(:name).paginate(per_page: 20, page: params[:page])
  end

  # GET /drugs/1
  # GET /drugs/1.json
  def show
    @drug.view_count += 1
    @drug.save
    @color = @drug.categories.first.cat_color
  end

  # GET /drugs/new
  def new
    @drug = Drug.new
  end

  # GET /drugs/1/edit
  def edit
  end

  # POST /drugs
  # POST /drugs.json
  def create
    @drug = Drug.new(drug_params)

    respond_to do |format|
      if @drug.save
        format.html { redirect_to @drug, notice: 'Drug was successfully created.' }
        format.json { render :show, status: :created, location: @drug }
      else
        format.html { render :new }
        format.json { render json: @drug.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /drugs/1
  # PATCH/PUT /drugs/1.json
  def update
    respond_to do |format|
      if @drug.update(drug_params)
        format.html { redirect_to @drug, notice: 'Drug was successfully updated.' }
        format.json { render :show, status: :ok, location: @drug }
      else
        format.html { render :edit }
        format.json { render json: @drug.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /drugs/1
  # DELETE /drugs/1.json
  def destroy
    @drug.destroy
    respond_to do |format|
      format.html { redirect_to drugs_url, notice: 'Drug was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def identical_drugs
    # todo: render ajax identical drugs view here
  end

  def pricey
    @drugs = Drug.pricey.paginate(per_page: 20, page: params[:page])
  end
  def cheap
    @drugs = Drug.cheap.paginate(per_page: 20, page: params[:page])
  end

  def recent
    @drugs = Drug.recent.paginate(per_page: 20, page: params[:page])
  end

  def trending
    @drugs = Drug.trending.paginate(per_page: 20, page: params[:page])
  end
  def popular
    @drugs = Drug.popular.paginate(per_page: 20, page: params[:page])
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_drug
      @drug = Drug.where(id: params[:id]).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def drug_params
      params.require(:drug).permit(:name, :generic_id, :country_id,
                                   :price, :concentration, :unit,
                                   :category, :image_url, :form_id,
                                   :contents, :company_id)
    end

    def set_identical_drugs
      @identical_drugs = @drug.identical_drugs(@drug.generics)
    end

end
