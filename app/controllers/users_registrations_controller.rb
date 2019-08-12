# frozen_string_literal: true

class UsersRegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  after_action :find_first_match, only: [:create, :update]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    handle_interests
    super
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    handle_interests
    super
  end

  # DELETE /resource
  def destroy
    super
  end

  def handle_interests
    if params[:user]['interests']
      interests = params[:user]['interests'].compact
      params[:user]['interest_list'] = interests.join(', ')
      params[:user].delete('interests')
    end
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    # super(resource)
    '/projects'
  end

  def after_update_path_for(resource)
    # user_path(resource)
    '/projects'
  end

  def find_first_match
    MatchCreator.create_match(resource)
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
