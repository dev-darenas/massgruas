class Vehicle < ApplicationRecord
  belongs_to :enterprise
  has_many :transactions
  has_many :documents, as: :documentable, dependent: :destroy

  validates :placa, presence: true
  validates :licencia, presence: true
  validates :clase, presence: true
  validates :marca, presence: true
  validates :tipo, presence: true
  validates :linea, presence: true

  has_many :pictures, as: :imageable, dependent: :destroy

  accepts_nested_attributes_for :pictures,
                                reject_if: lambda {
                                    |a| a[:image].blank?
                                }, allow_destroy: true
end
