class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :destroy]
  respond_to :js, :html, :json, :xml

  def show
    @user.view_count += 1
    @user.save

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @user, location: @user}
    end
  end
  def index
    @users = User.all.order(:created_at).paginate(per_page: 20, page: params[:page])
  end

  def edit
    redirect_to 'registrations/edit'
  end

  def destroy

  end

  def popular
    @users = User.popular.paginate(per_page: 20, page: params[:page])
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :profession, :id, :country)
  end

  def set_user
    @user =  User.where(id: params[:id]).first
  end
end
