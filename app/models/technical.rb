class Technical < ApplicationRecord
  acts_as_paranoid
  belongs_to :enterprise
  has_many :transactions
  has_many :bonding_dates
  has_many :documents, as: :documentable, dependent: :destroy

  has_many :pictures, as: :imageable, dependent: :destroy

  accepts_nested_attributes_for :pictures,
                                reject_if: lambda {
                                    |a| a[:image].blank? && a[:attachments].blank?
                                }, allow_destroy: true
  validates :nombre, presence: true
  validates :cedula, presence: true
  validates :cedula, uniqueness: {scope: :enterprise_id}

  scope :is_active, -> { where(active: 'true') }
  before_save :to_upper

  def age
    return '' unless self.fecha_nacimiento
    now = Time.now.utc.to_date
    now.year - self.fecha_nacimiento.year - (self.fecha_nacimiento.to_date.change(:year => now.year) > now ? 1 : 0)
  end

  def name_and_tel
    "#{self.nombre} telefonos: #{self.telefono1}, #{self.telefono2} "
  end

  def cedula_and_name
    "#{self.cedula} #{self.nombre}"
  end

end
