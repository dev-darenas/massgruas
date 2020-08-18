class Client < ApplicationRecord
  acts_as_paranoid
  belongs_to :enterprise
  has_many :transactions
  has_many :documents, as: :documentable
  has_many :list_prices
  has_and_belongs_to_many :accounts

  validates :nombre, presence: true
  validates :identificacion, presence: true
  validates :identificacion, uniqueness: { case_sensitive: false }
  validates :telefono, presence: true

  enum regimen: { 'COMUN': 'COMUN', SIMPLIFICADO: 'SIMPLIFICADO' }
  enum tipo_identificacion: {'CEDULA DE CIUDADANIA': 'CC', 'CEDULA DE EXTRANJERÍA':'CE', PASAPORTE:'P', 'REGISTRO CIVIL':'RC', NIT:'NIT'}
  before_save :to_upper

  def arrays_acounts
    @array = []
    self.accounts.each do |ac|
      @array.push([ac.id, ac.name])
    end
    @array
  end

  def identification_name
    "#{self.identificacion} #{self.nombre}"
  end

  private def to_upper
    self.direccion.try(:upcase!)
    self.actividad_comercial.try(:upcase!)
    self.nombre.try(:upcase!)
    self.ciudad.try(:upcase!)
  end

end
