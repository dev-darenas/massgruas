class Account < ApplicationRecord
  belongs_to :enterprise
  has_and_belongs_to_many :clients
  has_many :transactions

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  before_save :to_upper
end
