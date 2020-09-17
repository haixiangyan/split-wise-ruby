require 'custom_error'

class ApplicationController < ActionController::API
  rescue_from CustomError::MustSignInError, with: :render_must_sign_in
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def must_sign_in
    if current_user.nil?
      raise CustomError::MustSignInError
    end
  end

  def current_user
    @current_user ||= User.find_by_id session[:current_user_id]
  end

  def render_resource(resources)
    return head 404 if resources.nil?

    if resources.errors.empty?
      render json: {resource: resources}, status: 200
    else
      render json: {errors: resources.errors}, status: 422
    end
  end

  def render_must_sign_in
    render status: :unauthorized
  end

  def render_not_found
    render status: :not_found
  end
end
