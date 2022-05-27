class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :id_number, :last_name, :framework])
        devise_parameter_sanitizer.permit(:account_update, keys: [:name, :id_number, :last_name, :framework])
    end
end
