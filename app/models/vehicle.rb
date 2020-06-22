class Vehicle < ApplicationRecord
  belongs_to :enterprise
  has_many :pictures, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :pictures,
                                reject_if: lambda {
                                    |a| a[:image].blank?
                                }, allow_destroy: true
end
