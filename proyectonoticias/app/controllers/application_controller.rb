class ApplicationController < ActionController::Base
  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :update_sanitized_params, if: :devise_controller?

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :password, :password_confirmation, :role, :login)}
  end

  def is_owner
    redirect_to(home_index_path) if current_user.role != "admin" && current_user.id.to_s != params[:id]
  end

  def is_admin
    redirect_to(home_index_path) if current_user.role != "admin"
  end

end
