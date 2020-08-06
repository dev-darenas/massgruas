class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  private
  def to_upper
    attributes.keys.each do |attribute|
      self[attribute].try(:upcase!)
    end
  end
end
