class Transaction < ApplicationRecord
  validates :orden_Trabajo, uniqueness: true
  validates :remision, uniqueness: true
  validates :factura, uniqueness: true
  validate :sum_of_normal_zone_and_red_zone

  belongs_to :enterprise
  has_many :observations, as: :observable, dependent: :destroy
  has_many :pictures, as: :imageable, dependent: :destroy
  belongs_to :account
  belongs_to :client
  belongs_to :vehicle
  belongs_to :technical
  belongs_to :service

  accepts_nested_attributes_for :client
  accepts_nested_attributes_for :vehicle
  accepts_nested_attributes_for :technical
  accepts_nested_attributes_for :account

  delegate :nombre, :identificacion, :razon_social, :regimen, :actividad_comercial, :direccion, :ciudad,
           :telefono, :email, to: :client, prefix: true

  delegate :placa, :licencia, :clase, :marca, :tipo, :linea, :servicio, to: :vehicle, prefix: true

  delegate :nombre, :cedula, :cargo, :direccion, :telefono1, :telefono2, :fecha_nacimiento, :n_licencia,
           :categoria, :eps, :arl, to: :technical, prefix: true

  accepts_nested_attributes_for :observations,
                                reject_if: lambda {
                                    |a| a[:description].blank?
                                }, allow_destroy: true

  accepts_nested_attributes_for :pictures,
                                reject_if: lambda {
                                    |a| a[:image].blank?
                                }, allow_destroy: true

  enum status: { open: 'Open', delivered: 'Delivered', closed: 'Closed', invoiced: 'Invoiced'} do
    event :close do
      before do
        self.fecha_de_cierre = DateTime.now
        self.save
      end
      transition :delivered => :closed, if: -> {valid_ganancias}
    end

    event :deliver do
      transition :open => :delivered, if: -> {valid_celula_costo}
    end

    event :check_in do
      transition :closed => :invoiced
    end
  end

  scope :s_opened, -> { where(status: 'open') }
  scope :s_delivered, -> { where(status: 'delivered') }
  scope :s_closed, -> { where(status: 'closed') }
  scope :s_invoiced, -> {where(status: 'invoiced')}

  after_create :add_one_to_service_number

  def add_one_to_service_number
    self.enterprise.update(service_number: self.enterprise.service_number + 1)
  end

  def sum_of_normal_zone_and_red_zone
    sum = km_zona_normal + km_zona_roja
    if total_km != sum
      errors.add(:km_zona_normal, "the sum with red_zone_km is not equal to total_km")
      errors.add(:km_zona_roja, "the sum with km_zona_normal is not equal to total_km")
    end
  end

  def valid_celula_costo
    if celula_costo.blank?
      self.errors.add(:celula_costo, "It cant be empty")
      false
    else
      true
    end
  end

  def valid_ganancias
    if ganancias.blank?
      self.errors.add(:ganancias, "It cant be empty")
      false
    else
      true
    end
  end
end
