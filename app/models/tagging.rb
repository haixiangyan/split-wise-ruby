class Tagging < ApplicationRecord
  belongs_to :record
  belongs_to :tag
  validates_presence_of :record_id, :tag_id
end
