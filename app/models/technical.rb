class Technical < ApplicationRecord
  belongs_to :enterprise

  has_many :pictures, as: :imageable, dependent: :destroy

  accepts_nested_attributes_for :pictures,
                                reject_if: lambda {
                                    |a| a[:image].blank?
                                }, allow_destroy: true

  def age
    now = Time.now.utc.to_date
    now.year - self.fecha_nacimiento.year - (self.fecha_nacimiento.to_date.change(:year => now.year) > now ? 1 : 0)
  end

end
