require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Taggings" do
  let(:tag) { Tag.create! name: 'test' }
  let(:tag_id) { tag.id }
  let(:record) { Record.create! amount: 10000, category: 'income' }
  let(:record_id) { record.id }
  let(:tagging) { Tagging.create! tag: tag, record: record }
  let(:id) { tagging.id }
  let(:taggings) {
    (1..11).to_a.map do |n|
      Tagging.create! record: record, tag: Tag.create!(name: "test#{n}")
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
      # 没有访问 tagging
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
