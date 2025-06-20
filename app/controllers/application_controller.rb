class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [:email, :password, :password_confirmation, :userable_type, :first_name, :last_name, :speciality, :availibity, :birthday]


    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
  end
end
