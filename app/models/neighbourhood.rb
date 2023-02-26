class Neighbourhood < ApplicationRecord
  belongs_to :force

  validates :api_id, presence: true
  validates :name, presence: true
end
