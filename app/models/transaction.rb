class Transaction < ApplicationRecord
  validates :orden_Trabajo, uniqueness: true

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

  enum status: { open: 'Open', delivered: 'Delivered', closed: 'Closed' } do
    event :close do
      before do
        self.fecha_de_cierre = DateTime.now
        self.save
      end
      transition all - [:closed] => :closed
    end
  end

  scope :s_opened, -> { where(status: 'open') }
  scope :s_delivered, -> { where(status: 'delivered') }
  scope :s_closed, -> { where(status: 'closed') }
  after_create :add_one_to_service_number

  def add_one_to_service_number
    self.enterprise.update(service_number: self.enterprise.service_number + 1)
  end
end
