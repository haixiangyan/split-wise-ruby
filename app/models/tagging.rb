class Tagging < ApplicationRecord
  belongs_to :record, required: true
  belongs_to :tag, required: true
end
