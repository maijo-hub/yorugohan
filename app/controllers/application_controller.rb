class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top], unless: :admin_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def admin_controller?
    self.class.module_parent_name == 'Admin'
  end

  def after_sign_up_path_for(resource)
    dinners_path
  end

  def after_sign_in_path_for(resource)
    dinners_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :profile])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :profile])
  end
end
