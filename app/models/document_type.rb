class DocumentType < ApplicationRecord
  belongs_to :enterprise
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  before_save :to_upper
end
