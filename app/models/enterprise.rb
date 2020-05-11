class Enterprise < ApplicationRecord
  has_many :users
  has_many :clients
  has_many :vehicles
end
