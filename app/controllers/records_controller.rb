class RecordsController < ApplicationController
  before_action :must_sign_in

  def index
    render_resources Record.page(params[:page])
  end

  def show
    render_resource Record.find(params[:id])
  end

  def update
    record = Record.find(params[:id])
    record.update create_params
    render_resource record
  end

  def create
    render_resource Record.create create_params
  end

  def destroy
    record = Record.find params[:id]
    head record.destroy ? :ok : :bad_request
  end

  private

  def render_resources(resources)
    render json: {resources: resources}
  end

  def create_params
    params.permit(:amount, :category, :note)
  end
end
