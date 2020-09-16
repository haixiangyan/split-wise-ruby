class Record < ApplicationRecord
  validates_presence_of :amount, :category
end
