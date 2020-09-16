require 'rails_helper'

RSpec.describe "Records", type: :request do
  it 'should not create a record before login' do
    post '/records', params: {amount: 10000, category: 'outgoings', note: '请客'}
    expect(response.status).to eq 401
  end
  it 'should create a record' do
    post '/records', params: {amount: 10000, category: 'outgoings', note: '请客'}
    expect(response.status).to eq 200

    body = JSON.parse(response.body)

    expect(body["resources"]["id"]).to be
  end
  it 'should not create a record' do
    post '/records', params: {category: 'outgoings', note: '请客'}
    expect(response.status).to eq 422

    body = JSON.parse(response.body)

    expect(body["errors"]["amount"][0]).to eq '金额不能为空'
  end
end
