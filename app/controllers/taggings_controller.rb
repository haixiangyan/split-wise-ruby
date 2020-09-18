class TaggingsController < ApplicationController
  before_action :must_sign_in

  def create
    render_resource Tagging.create create_params
  end

  private

  def create_params
    params.permit(:record_id, :tag_id)
  end
end
