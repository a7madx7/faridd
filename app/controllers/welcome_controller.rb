class WelcomeController < ApplicationController
  def home
    @users = User.all
  end

  def about
  end
end
