require 'rails_helper'

RSpec.describe Record, type: :model do
  it 'amount is required' do
    record = Record.create note: 'xxx', category: 'outgoings'
    expect(record.errors.details[:amount][0][:error]).to eq(:blank)
  end
  it 'category is required' do
    record = Record.create note: 'xxx', note: 'xxx'
    expect(record.errors.details[:amount][0][:error]).to eq(:blank)
  end
end
