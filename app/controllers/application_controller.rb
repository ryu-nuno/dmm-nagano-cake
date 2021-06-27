class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def after_sign_in_path_for(resource)
    case resource
    when Customer
      root_path
    when Admin
      admins_root_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :first_name, :last_name, :first_name_kana, :last_name_kana, :phone_number, :postal_code, :address])
  end

end
