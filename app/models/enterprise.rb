class Enterprise < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :clients, dependent: :destroy
  has_many :vehicles, dependent: :destroy
  has_many :technicals, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :document_types, dependent: :destroy
  has_many :services, dependent:  :destroy
  has_many :accounts, dependent: :destroy
end
