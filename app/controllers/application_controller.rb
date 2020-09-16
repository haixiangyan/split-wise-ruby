require 'custom_error'

class ApplicationController < ActionController::API
  rescue_from CustomError::MustSignInError, with: :render_must_sign_in

  def must_sign_in
    if current_user.nil?
      raise CustomError::MustSignInError
    end
  end

  def current_user
    @current_user ||= User.find_by_id session[:current_user_id]
  end

  def render_resources(resources)
    return head 404 if resources.nil?

    if resources.errors.empty?
      render json: {resources: resources}, status: 200
    else
      render json: {errors: resources.errors}, status: 422
    end
  end

  def render_must_sign_in
    render status: :unauthorized
  end
end
