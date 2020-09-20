require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Taggings" do
  let(:tag) { create :tag }
  let(:tag_id) { tag.id }
  let(:user) { User.create email: '1@qq.com', password: '123456', password_confirmation: '123456' }
  let(:record) { Record.create! amount: 10000, category: 'income', user: user }
  let(:record_id) { record.id }
  let(:tagging) { Tagging.create! tag: tag, record: record }
  let(:id) { tagging.id }
  let(:taggings) {
    (1..11).to_a.map do |n|
      Tagging.create! record: record, tag: create(:tag, name: "test#{n}")
    end
  }
  let(:create_taggings) {
    tagging
    taggings
    nil
  }

  post '/taggings' do
    parameter :tag_id, '标签 ID', type: :number, required: true
    parameter :record_id, '记录 ID', type: :number, required: true
    example '创建标记' do
      sign_in
      do_request
      expect(status).to eq 200
    end
  end

  delete "/taggings/:id" do
    example "删除标记" do
      sign_in
      do_request
      expect(status).to eq 200
    end
  end

  get "/taggings" do
    parameter :page, '页码', type: :integer
    let(:page) { 1 }
    example "获取所有标记" do
      # 惰性创建，只有访问了 tagging 才会创建
      create_taggings
      sign_in
      do_request
      expect(status).to eq 200
    end
  end

  get "/taggings/:id" do
    example "获取一个标记" do
      sign_in
      do_request
      expect(status).to eq 200
    end
  end
end
