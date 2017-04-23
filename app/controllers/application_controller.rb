class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  #Niki: Start - Add full name to sign-up and account_update page
  #Nikki: Due to security reasons we need to explicitly permit parameters in each controller
  #Nikki: The devise gem hadles the entire lifecycle
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected 
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:fullname])
    devise_parameter_sanitizer.permit(:account_update, keys: [:fullname, :phone_number, :description, :email, :password])
  end
  #Niki: End -Add full name to sign-up and account_update page
end
