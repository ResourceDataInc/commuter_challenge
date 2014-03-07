class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :inject_authorized_paramaters_into_the_request_so_cancan_will_play_nice_with_strong_parameters

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  helper_method :current_competition
  def current_competition
    @current_competition ||= Competition.by_start_date.first
  end

  helper_method :current_membership
  def current_membership
    if current_competition
      @current_membership ||= current_user.memberships.joins(:competition)
        .where(["competitions.id = ?", current_competition.id])
        .first
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
    devise_parameter_sanitizer.for(:account_update) << :username
  end

  # omg
  def inject_authorized_paramaters_into_the_request_so_cancan_will_play_nice_with_strong_parameters
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end
end
