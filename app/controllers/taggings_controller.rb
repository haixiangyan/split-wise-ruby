class TaggingsController < ApplicationController
  before_action :must_sign_in

  def create
    render_resource Tagging.create create_params.merge user: current_user
  end

  def destroy
    tagging = Tagging.find params[:id]
    head tagging.destroy ? :ok : :bad_request
  end

  def index
    render_resources Tagging.page(params[:page])
  end

  def show
    render_resource Tagging.find(params[:id])
  end

  private

  def render_resources(resources)
    render json: {resources: resources}
  end

  def create_params
    params.permit(:record_id, :tag_id)
  end
end
