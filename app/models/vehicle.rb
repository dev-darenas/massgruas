class Vehicle < ApplicationRecord
  acts_as_paranoid
  belongs_to :enterprise
  has_many :transactions
  has_many :documents, as: :documentable, dependent: :destroy

  validates :placa, presence: true
  validates :placa, uniqueness: {scope: :enterprise_id, case_sensitive: false }
  validates :licencia, presence: true
  validates :clase, presence: true
  validates :marca, presence: true
  validates :tipo, presence: true
  validates :linea, presence: true

  has_many :pictures, as: :imageable, dependent: :destroy

  accepts_nested_attributes_for :pictures,
                                reject_if: lambda {
                                    |a| a[:image].blank? && a[:attachments].blank?
                                }, allow_destroy: true

  before_save :to_upper

  scope :is_active, -> { where(active: true) }
end
