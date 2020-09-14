class ApplicationController < ActionController::API
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
end
