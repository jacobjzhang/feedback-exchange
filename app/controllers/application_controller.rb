class ApplicationController < ActionController::Base
  include ProjectHelper

  protect_from_forgery with: :exception
  before_action :store_user_location!, if: :storable_location?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_unread_scorecards, if: :current_user

  def after_sign_in_path_for(resource_or_scope)
    # stored_location_for(resource_or_scope) || matches_path || super
    # save list if there is a temp_list in the session
    if session[:project].present?
      handle_project_signup
      session.delete(:project)
      projects_path || super
    else
      #if there is not temp list in the session proceed as normal
      review_path || matches_path || super
    end
  end

  private
  # Its important that the location is NOT stored if:
  # - The request method is not GET (non idempotent)
  # - The request is handled by a Devise controller such as Devise::SessionsController as that could cause an 
  #    infinite redirect loop.
  # - The request is an Ajax request as this can lead to very unexpected behaviour.
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :interest_list])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :interest_list])
  end

  def check_unread_scorecards
    @unread_scorecards ||= current_user_scorecards.with_read_marks_for(current_user).select do |sc|
      sc.unread?(current_user)
    end
  end

  def current_user_scorecards
    @current_user_scorecards ||= ScoreCard.joins(:project).where("projects.user_id = #{current_user.id}")
  end
end