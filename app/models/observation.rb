class Observation < ApplicationRecord
  belongs_to :user
  belongs_to :observable, polymorphic: true
  before_save :to_upper

  private
  def to_upper
    self.description.try(:upcase!)
  end
end
