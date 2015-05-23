class UserController < ApplicationController
  before_action :authenticate_user?, only: [:update,:destroy]
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:admin_type,:email,:password,:password_confirmation) }
  end

  def admin_params
    params.require(:admin).permit(:email,:admin_type,:password, :password_confirmation)
  end

end