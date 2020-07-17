class Account < ApplicationRecord
  belongs_to :enterprise
  has_and_belongs_to_many :clients

  validates :name, presence: true
end