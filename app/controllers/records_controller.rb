class RecordsController < ApplicationController
  def create
    render_resources Record.create create_params
  end

  def create_params
    p params
    params.permit(:amount, :category, :note)
  end
end
