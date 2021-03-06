class Service < ApplicationRecord
  acts_as_paranoid
  belongs_to :enterprise
  has_one :list_price
  has_many :transactions
  validates :name, presence: true
  validates :name, uniqueness: {scope: :enterprise_id, case_sensitive: false }
  before_save :to_upper
end
