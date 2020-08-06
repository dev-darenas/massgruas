class Service < ApplicationRecord
  belongs_to :enterprise
  has_one :list_price
  has_many :transactions
  validates :name, presence: true
  validates :name, uniqueness: true
  before_save :to_upper
end
