require 'rails_helper'

RSpec.describe Tagging, type: :model do
  before :each do
    @user = create :user
  end

  it 'require record' do
    tag = Tag.create name: 'test'
    tagging = Tagging.create tag: tag

    expect(tagging.errors.details[:record][0][:error]).to eq :blank
    expect(tagging.errors[:record][0]).to eq '记录不能为空'
  end
  it 'require tag' do
    record = Record.create amount: 10000, category: 'income', note: 'hello'
    tagging = Tagging.create record: record

    expect(tagging.errors.details[:tag][0][:error]).to eq :blank
    expect(tagging.errors[:tag][0]).to eq '标签名不能为空'
  end
  it 'has record and tag' do
    user = User.create email: '1@qq.com', password: '123456', password_confirmation: '123456'
    tag = Tag.create name: 'test'
    record = Record.create amount: 10000, category: 'income', note: 'hello', user: user
    Tagging.create tag: tag, record: record

    expect(tag.records.first.id).to eq record.id
    expect(record.tags.first.id).to eq tag.id
  end
  it 'has records and tags' do
    tag1 = Tag.create! name: 'test1'
    tag2 = Tag.create! name: 'test2'
    record1 = Record.create amount: 10000, category: 'income', user: @user
    record2 = Record.create amount: 10000, category: 'income', user: @user

    Tagging.create tag: tag1, record: record1
    Tagging.create tag: tag1, record: record2
    Tagging.create tag: tag2, record: record1
    Tagging.create tag: tag2, record: record2

    expect(tag1.records.count).to eq 2
    expect(tag2.records.count).to eq 2
    expect(record1.tags.count).to eq 2
    expect(record2.tags.count).to eq 2
  end
end
