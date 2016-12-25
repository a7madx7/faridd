class WelcomeController < ApplicationController
  def home
    @users = User.all.order('created_at desc')
  end

  def about
  end
end
