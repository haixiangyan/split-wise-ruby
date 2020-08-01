class ApplicationController < ActionController::API
  def render_resources(resources)
    if resources.errors.empty?
      render json: {resources: resources}, status: 200
    else
      render json: {errors: resources.errors}, status: 400
    end
  end
end
