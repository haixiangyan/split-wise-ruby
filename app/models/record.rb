class Record < ApplicationRecord
  has_many :taggings # 拥有很多从属
  has_many :tags, through: :taggings # 间接关系也有很多 tags
  belongs_to :user
  enum category: { outgoings: 1, income: 2 }
  validates_presence_of :amount, :category
end
