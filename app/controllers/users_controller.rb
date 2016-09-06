class UsersController < ApplicationController
  def show
    @user =  User.where(id: params[:id]).first
    respond_to do |format|
      format.html
      format.js
      format.json { render json: @user, location: @user}
    end
  end
  def index

  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end


  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :profession, :id, :country)
  end
end
