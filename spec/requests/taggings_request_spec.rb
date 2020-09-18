require 'rails_helper'

RSpec.describe "Taggings", type: :request do
  context 'create' do
    it 'should not create tagging before sign in' do
      post '/taggings'
      expect(response.status).to eq 401
    end
    it 'should create a tagging' do
      sign_in
      record = Record.create! amount: 10000, category: 'income'
      tag = Tag.create! name: 'test'
      post '/taggings', params: {record_id: record.id, tag_id: tag.id}
      expect(response.status).to eq 200

      body = JSON.parse(response.body)
      expect(body['resource']['id']).to be
    end
    it 'should not create a tagging without record_id' do
      sign_in
      tag = Tag.create! name: 'test'
      post '/taggings', params: {tag_id: tag.id}
      expect(response.status).to eq 422

      body = JSON.parse(response.body)
      expect(body['errors']['record'][0]).to eq '记录不能为空'
    end
  end
end
