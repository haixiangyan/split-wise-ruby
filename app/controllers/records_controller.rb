class RecordsController < ApplicationController
  def create
    must_sign_in
    render_resources Record.create create_params
  end

  def destroy
    must_sign_in
    record = Record.find params[:id]
    head record.destroy ? :ok : :bad_request
  end

  def create_params
    p params
    params.permit(:amount, :category, :note)
  end
end
