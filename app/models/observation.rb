class Observation < ApplicationRecord
  acts_as_paranoid
  belongs_to :user
  belongs_to :observable, polymorphic: true
  before_save :to_upper

  private
  def to_upper
    self.description.try(:upcase!)
  end
end
