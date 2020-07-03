class Transaction < ApplicationRecord
  belongs_to :enterprise
  has_many :observations, as: :observable, dependent: :destroy
  has_many :pictures, as: :imageable, dependent: :destroy
  belongs_to :client

  accepts_nested_attributes_for :client

  delegate :nombre, :identificacion, :razon_social, :regimen, :actividad_comercial, :direccion, :ciudad,
           :telefono, :email, to: :client, prefix: true

  accepts_nested_attributes_for :observations,
                                reject_if: lambda {
                                    |a| a[:description].blank?
                                }, allow_destroy: true

  accepts_nested_attributes_for :pictures,
                                reject_if: lambda {
                                    |a| a[:image].blank?
                                }, allow_destroy: true

  enum status: { open: 'Open', delivered: 'Delivered', closed: 'Closed'}

  scope :s_opened, -> { where(status: 'open') }
  scope :s_delivered, -> { where(status: 'delivered') }
  scope :s_closed, -> { where(status: 'closed') }

  def changed_date_closed
    self.fecha_de_cierre=Time.now
  end

end
