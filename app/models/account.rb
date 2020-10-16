class Account < ApplicationRecord
  acts_as_paranoid

  belongs_to :enterprise
  has_and_belongs_to_many :clients
  has_many :transactions, class_name: 'Transaction'

  validates :name, presence: true
  validates :name, uniqueness: {scope: :enterprise_id, case_sensitive: false }
  before_save :to_upper
end
