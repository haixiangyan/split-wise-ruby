require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Records" do
  post "/records" do
    parameter :amount, '金额', type: :integer, required: true
    parameter :category, '类型: 1 outgoings | 2 income', type: :string, required: true
    parameter :note, '备注', type: :string
    example "创建记账" do
      do_request(amount: 10000, category: 'income', note: '吃饭')
      expect(status).to eq 200
    end
  end
end
