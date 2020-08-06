class BondingDate < ApplicationRecord
  belongs_to :technical
  before_save :to_upper
end
