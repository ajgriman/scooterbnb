class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :layout_by_resource

  protected

  def layout_by_resource
    if devise_controller?
      "devise"  # Uses app/views/layouts/devise.html.erb for Devise actions
    else
      "application"  # The default layout for other parts of your app
    end
  end

  def configure_permitted_parameters
    added_attrs = [:name, :bio, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
  end
end
