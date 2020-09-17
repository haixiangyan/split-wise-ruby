require 'rails_helper'

RSpec.describe "Users", type: :request do
  it 'should create a user' do
    post '/users', params: {email: ''}
    expect(response.status).to eq 422
    body = JSON.parse(response.body)
    expect(body["errors"]["email"][0]).to eq '邮箱不能为空'
    expect(body["errors"]["password"][0]).to eq '密码不能为空'
    expect(body["errors"]["password_confirmation"][0]).to eq '请填写确认密码'
  end
  it 'should not get current user' do
    get '/me'
    expect(response).to have_http_status :not_found
  end
  it 'should get current user' do
    user = sign_in
    get '/me'

    body = JSON.parse(response.body)

    expect(response).to have_http_status :ok
    expect(body["resource"]["id"]).to eq user.id
  end
end
