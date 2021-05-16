class ApplicationController < ActionController::Base
  #include SessionsHelper -fromRailsTutorial
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :email, :password, :remember_me])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
