class UsersController < ApplicationController
  def create
    render_resource User.create create_params
  end

  def create_params
    params.permit(:email, :password, :password_confirmation)
  end

  def me
    render_resource current_user
  end
end
