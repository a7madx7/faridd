class UsersController < ApplicationController
  def show
    @user = User.where(id: params[:id])
  end
  def index

  end

  def edit

  end


  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :profession, :id, :country)
  end
end
