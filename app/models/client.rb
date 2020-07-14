class Client < ApplicationRecord
  belongs_to :enterprise
  has_many :transactions
  has_many :documents, as: :documentable
  has_many :list_prices

  validates :nombre, presence: true
  validates :identificacion, presence: true
  validates :telefono, presence: true

  enum regimen: { common: 'Comun', simplified: 'Simplificado' }

end
