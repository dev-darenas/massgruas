class Service < ApplicationRecord
  belongs_to :enterprise
  has_one :list_price
  has_many :transactions
end
