require 'rails_helper'

RSpec.describe "Tags", type: :request do
  context 'create' do
    it 'should not create a tag before sign in' do
      post '/tags', params: { name: 'test' }
      expect(response.status).to eq 401
    end
    it 'should create a tag' do
      sign_in
      post '/tags', params: { name: 'test' }
      expect(response.status).to eq 200

      body = JSON.parse(response.body)
      expect(body["resource"]["id"]).to be
    end
    it 'should not create tag without name' do
      sign_in
      post '/tags'
      expect(response.status).to eq 422
      body = JSON.parse(response.body)
      expect(body["errors"]["name"][0]).to eq '标签名不能为空'
    end
  end

  context 'index' do
    it 'should not get tag list before sign in' do
      get '/tags'
      expect(response.status).to eq 401
    end
    it 'should get tag list' do
      (1..11).to_a.map do |n|
        create :tag, name: "test#{n}"
      end

      sign_in

      get '/tags'

      expect(response.status).to eq 200
      body = JSON.parse(response.body)
      expect(body['resources'].length).to eq 10
    end
  end

  context 'show' do
    it 'should not get a tag before sign in' do
      tag = create :tag, name: 'test'
      get "/tags/#{tag.id}"
      expect(response.status).to eq 401
    end
    it 'should not found' do
      sign_in
      get "/tags/9999"
      expect(response.status).to eq 404
    end
  end

  context 'destroy' do
    it 'should not destroy a tag before sign in' do
      tag = create :tag, name: 'test'

      delete "/tags/#{tag.id}"

      expect(response.status).to eq 401
    end
    it 'should destroy a tag' do
      sign_in
      tag = create :tag, name: 'test'

      delete "/tags/#{tag.id}"

      expect(response.status).to eq 200
    end
  end

  context 'update' do
    it 'should not update a tag before sign in' do
      tag = create :tag, name: 'hello'
      patch "/tags/#{tag.id}", params: {name: 'new'}
      expect(response.status).to eq 401
    end
    it 'should update a tag' do
      sign_in
      tag = create :tag, name: 'hello'
      patch "/tags/#{tag.id}", params: {name: 'new'}
      expect(response.status).to eq 200

      body = JSON.parse response.body
      p body
      expect(body["resource"]["name"]).to eq 'new'
    end
  end
end
