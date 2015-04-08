class UserController < ApplicationController
  before_action :authenticate_user?, only: [:store,:update,:destroy]
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:provider, :uid,:email) }
    end

    def user_params
      params.require(:user).permit(:name,:username,:email,:provider,:uid,:profile_image,:country)
    end

end