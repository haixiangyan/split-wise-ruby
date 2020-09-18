class TagsController < ApplicationController
  before_action :must_sign_in

  def index
    render_resources Tag.page(params[:page])
  end

  def show
    render_resource Tag.find(params[:id])
  end

  def create
    render_resource Tag.create create_params
  end

  def update
    tag = Tag.find(params[:id])
    tag.update create_params
    render_resource tag
  end

  def destroy
    tag = Tag.find params[:id]
    head tag.destroy ? :ok : :bad_request
  end

  private

  def render_resources(resources)
    render json: {resources: resources}
  end

  def create_params
    params.permit(:name)
  end
end
