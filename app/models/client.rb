class Client < ApplicationRecord
  belongs_to :enterprise

  validates :nombre, presence: true
  validates :identificacion, presence: true
  validates :telefono, presence: true

  enum regimen: { common: 'Comun', simplified: 'Simplificado' }

end
