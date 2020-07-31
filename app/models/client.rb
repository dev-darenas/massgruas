class Client < ApplicationRecord
  belongs_to :enterprise
  has_many :transactions
  has_many :documents, as: :documentable
  has_many :list_prices
  has_and_belongs_to_many :accounts

  validates :nombre, presence: true
  validates :identificacion, presence: true
  validates :identificacion, uniqueness: true
  validates :telefono, presence: true

  enum regimen: { common: 'Comun', simplified: 'Simplificado' }
  enum tipo_identificacion: {'Cedula de Ciudadanía': 'CC', 'Cedula de Extranjería':'CE', Pasaporte:'P', 'Registro Civil':'RC'}

  def arrays_acounts
    @array = []
    self.accounts.each do |ac|
      @array.push([ac.id, ac.name])
    end
    @array
  end

end
