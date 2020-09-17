class RecordsController < ApplicationController
  before_action :must_sign_in

  def index
    render_resources Record.page(params[:page])
  end

  def show
    render_resources Record.find(params[:id])
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
    p params
    params.permit(:amount, :category, :note)
  end
end
