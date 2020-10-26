class Enterprise < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :clients, dependent: :destroy
  has_many :vehicles, dependent: :destroy
  has_many :technicals, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :document_types, dependent: :destroy
  has_many :services, dependent:  :destroy
  has_many :accounts, dependent: :destroy
  has_many :pictures, as: :imageable
  has_many :documents, as: :documentable, dependent: :destroy

  accepts_nested_attributes_for :users,
                                reject_if: lambda {
                                    |a| a[:email].blank?
                                }
  accepts_nested_attributes_for :pictures,
                                reject_if: lambda {
                                    |a| a[:image].blank?
                                }, allow_destroy: true
  before_save :to_upper
end
