class Vehicle < ApplicationRecord
  belongs_to :enterprise
  has_many :pictures, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :pictures
end
