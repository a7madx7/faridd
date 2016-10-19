class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :invoke_thumbnailer, only: [:search]

  semantic_breadcrumb :index, :root_path

  def invoke_thumbnailer
    [@drug_results, @generic_results, @user_results].each do |result|
      begin
        result.each do |res|
          begin
            res.image_url = LinkThumbnailer.generate("http://en.wikipedia.org/wiki/#{res.name}").images.first.src.to_s
          rescue
            next
          ensure
            res.save
          end unless res.image_url
        end
      rescue
        next
      end
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

end
