class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update, :destroy]

  # GET /trade_center
  # GET /trade_center.json
  def index
    @offers = Offer.all.paginate(per_page: 20, page: params[:page])
  end
  # GET /trade_center/recent
  # GET /trade_center/recent.json
  def recent
    @offers = Offer.recent.paginate(per_page: 20, page: params[:page])
  end
  # GET /trade_center/trending
  # GET /trade_center/trending.json
  def trending
    @offers = Offer.trending.paginate(per_page: 20, page: params[:page])
  end
  # GET /trade_center/best_value
  # GET /trade_center/best_value.json
  def best_value
    @offers = Offer.trending.paginate(per_page: 20, page: params[:page])
  end

  # GET /offers/1
  # GET /offers/1.json
  def show
  end

  # GET /offers/new
  def new
    @offer = Offer.new
  end

  # GET /offers/1/edit
  def edit
  end

  # POST /offers
  # POST /offers.json
  def create
    @offer = Offer.new(offer_params)

    respond_to do |format|
      if @offer.save
        format.html { redirect_to @offer, notice: 'Offer was successfully created.' }
        format.json { render :show, status: :created, location: @offer }
      else
        format.html { render :new }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /offers/1
  # PATCH/PUT /offers/1.json
  def update
    respond_to do |format|
      if @offer.update(offer_params)
        format.html { redirect_to @offer, notice: 'Offer was successfully updated.' }
        format.json { render :show, status: :ok, location: @offer }
      else
        format.html { render :edit }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offers/1
  # DELETE /offers/1.json
  def destroy
    @offer.destroy
    respond_to do |format|
      format.html { redirect_to offers_url, notice: 'Offer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offer
      @offer = Offer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def offer_params
      params.require(:offer).permit(:drug_id, :user_id, :discount, :expiry, :amount)
    end
end
