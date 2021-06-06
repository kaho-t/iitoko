class ApplicationController < ActionController::Base
  #include SessionsHelper -fromRailsTutorial
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :authenticate_local!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    case resource
    when User
      top_path
    when Local
      local_path(@local)
    end
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:prefecture_code, :name, :email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :email, :password, :remember_me])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

end
