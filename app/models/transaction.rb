class Transaction < ApplicationRecord
  acts_as_paranoid
  validates :orden_Trabajo, presence: true
  validates :orden_Trabajo, uniqueness: {scope: :enterprise_id}
  validate :sum_of_normal_zone_and_red_zone

  belongs_to :enterprise
  has_many :observations, as: :observable, dependent: :destroy
  has_many :pictures, as: :imageable, dependent: :destroy
  belongs_to :account
  belongs_to :account_including_deleted, class_name: "Account",
             foreign_key: 'account_id', with_deleted: true
  belongs_to :client
  belongs_to :client_including_deleted, class_name: "Client",
      foreign_key: 'client_id', with_deleted: true
  belongs_to :vehicle
  belongs_to :vehicle_including_deleted, class_name: "Vehicle",
             foreign_key: 'vehicle_id', with_deleted: true
  belongs_to :technical
  belongs_to :technical_including_deleted, class_name: "Technical",
             foreign_key: 'technical_id', with_deleted: true
  belongs_to :service
  belongs_to :service_including_deleted, class_name: "Service",
             foreign_key: 'service_id', with_deleted: true

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
                                    |a| a[:image].blank? && a[:attachments].blank?
                                }, allow_destroy: true

  enum status: {ABIERTO: 'Open', ENVIADO: 'Delivered', CERRADO: 'Closed', FACTURADO: 'Invoiced'} do
    event :close do
      before do
        self.fecha_de_cierre = DateTime.now
        self.save
      end
      transition :ENVIADO => :CERRADO, if: -> {valid_ganancias}
      transition :FACTURADO => :CERRADO
    end

    event :deliver do
      transition :ABIERTO => :ENVIADO, if: -> {valid_celula_costo}
      transition :CERRADO => :ENVIADO
    end

    event :open do
      transition :CERRADO => :ABIERTO
      transition :FACTURADO => :ABIERTO
      transition :ENVIADO => :ABIERTO
    end

    event :check_in do
      transition :CERRADO => :FACTURADO
    end
  end

  scope :s_opened, -> { where(status: 'Open') }
  scope :s_delivered, -> { where(status: 'Delivered') }
  scope :s_closed, -> { where(status: 'Closed') }
  scope :s_invoiced, -> {where(status: 'Invoiced')}

  after_create :add_one_to_service_number
  before_save :to_upper

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

  private
  def to_upper
    self.tarea.try(:upcase!)
    self.asegurado.try(:upcase!)
    self.direccion.try(:upcase!)
    self.operador.try(:upcase!)
    self.celula_costo.try(:upcase!)
  end
end
