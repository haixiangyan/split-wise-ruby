class SessionsController < ApplicationController
  def create
    s = Session.new create_params

    s.validate

    render_resource s

    session[:current_user_id] = s.user.id
  end

  def destroy
    session[:current_user_id] = nil
    head 200
  end

  def create_params
    params.permit(:email, :password)
  end
end
