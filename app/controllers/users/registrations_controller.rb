# app/controllers/users/registrations_controller.rb

class Users::RegistrationsController < Devise::RegistrationsController
  # We are overriding the 'create' action just to add logging.
  def create
    # Log #1: The raw parameters received by the controller.
    Rails.logger.info "--- REGISTRATION CREATE ACTION ---"
    Rails.logger.info "Raw Parameters: #{params.inspect}"

    # This calls the original Devise 'create' method to let it do its work.
    super
  end

  # Add this empty method to inspect what Devise is permitting.
  # This is where the 'configure_permitted_parameters' logic would normally go.
  def configure_sign_up_params
    # Log #2: The parameters after Devise's sanitizer has run.
    # We need to access the internal 'params' of the sanitizer.
    sanitizer = self.send(:devise_parameter_sanitizer)
    permitted_params = sanitizer.send(:params)
    Rails.logger.info "Permitted Parameters (after sanitization): #{permitted_params.inspect}"

    # This calls the original Devise method.
    super
  end
end