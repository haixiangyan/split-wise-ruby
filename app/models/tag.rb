class Tag < ApplicationRecord
  has_many :taggings
  has_many :records, through: :taggings
  belongs_to :user
  validates_presence_of :name
end
