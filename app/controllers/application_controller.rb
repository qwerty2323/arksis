class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :user_active!, only: [:secret] 
  protect_from_forgery with: :exception

  protected

  def user_active!
    true unless current_user.status == 0
    redirect_to root_url, notice: 'Your account is locked.'
    false
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |user_params|
      user_params.permit(:name, :last_name, :email, :cellphone, :status, :password)
    end
    devise_parameter_sanitizer.for(:account_update) do |user_params|
      user_params.permit(:name, :last_name, :email, :cellphone, :status, :password, :current_password)
    end
  end
end
