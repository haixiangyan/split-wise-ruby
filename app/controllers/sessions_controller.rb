class SessionsController < ApplicationController
  def create
    session = Session.new create_params

    session.validate

    render_resources session

    # session[:current_user_id] = session.user.id
  end

  def destroy

  end

  def create_params
    params.permit(:email, :password)
  end
end
