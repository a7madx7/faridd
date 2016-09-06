class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :prepare_menu, unless: :devise_controller?

  def search
    @drug_results = Drug.search(params[:term]).order(:name).first(5)
    # @generic_results = Generic.search(params[:term]).order(:name).first(5)
    # @user_results = User.search(column: 'username', term: params[:term]).order(:first_name).first(5)
    respond_to do |format|
      format.js { render 'layouts/search' }
      format.json { render file: 'layouts/search', content_type: 'application/json' }
      format.html { render 'layouts/search' }
    end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :first_name, :last_name, :profession, :gender, :username, :country])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :first_name, :last_name, :profession, :gender, :username, :country])
  end

  def prepare_menu
    @menu ||= {}
    if current_user
      case current_user.profession.downcase
        when 'pharmacist'
          @menu = { 'generics' => [ generics_path, 'lab' ], 'trade names' => ['/trade_names', 'registered'],
                    'formulations' => ['/formulations', 'idea'],
                    'rxs' => ['/rxs', 'heartbeat'], 'questions' => ['/questions', 'book'],
                    'trade center' => ['/trade_center', 'percent'] }
        when 'physician'
          @menu = { 'generics' => [generics_path, 'lab'], 'rxs' => ['/rxs', 'heartbeat'],
                    'questions' => ['/questions', 'book'],
                    'clinic' => ['/clinic', 'doctor'], 'patients' => ['/patients', 'user'] }
        when 'student'
          @menu = { 'generics' => [generics_path, 'lab'], 'trade names' => ['/trade_names', 'registered'],
                    'formulations' => ['/formulations', 'idea'],
                    'questions' => ['/questions', 'book'] }
        else
          @menu = { 'trade names' => ['/trade_names', 'registered'],
                    'trade center' => ['/trade_center', 'percent'] }
      end
    else

    end
    @menu
  end

end
