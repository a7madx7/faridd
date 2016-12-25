class ApplicationController < ActionController::Base
  include PublicActivity::StoreController

  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :prepare_stats

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :first_name, :last_name, :profession, :gender, :username, :country])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :first_name, :last_name, :profession, :gender, :username, :country])
  end

  private
  def prepare_menu
    @menu ||= {}
    if current_user
      case current_user.profession.downcase
        when 'pharmacist'
          @menu = { 'generics' => ['lab'], 'drugs' => ['registered'],
                    'formulations' => ['idea'],
                    'rxes' => ['heartbeat'], 'questions' => ['book'],
                    'trade center' => ['percent'] }
        when 'physician'
          @menu = { 'generics' => ['lab'], 'rxs' => ['heartbeat'],
                    'questions' => [ 'book'],
                    'clinic' => ['doctor'], 'patients' => ['user'] }
        when 'student'
          @menu = { 'generics' => ['lab'], 'drugs' => ['registered'],
                    'formulations' => ['idea'],
                    'questions' => ['book'] }
        else
          @menu = { 'drugs' => ['registered'],
                    'trade center' => ['percent'] }
      end
    else

    end
    @menu
  end

  def prepare_stats
    # session.clear
    # unless session[:cheap_cats]
    #   session[:cheap_cats] = Category.cheap
    # end
    # unless session[:pricey_cats]
    #   session[:pricey_cats] = Category.pricey
    # end
  end
end
