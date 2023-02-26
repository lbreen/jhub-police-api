class Force < ApplicationRecord
  has_many :neighbourhoods

  validates :api_id, presence: true
  validates :name, presence: true
end
