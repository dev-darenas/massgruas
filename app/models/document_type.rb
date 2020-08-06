class DocumentType < ApplicationRecord
  belongs_to :enterprise
  validates :name, presence: true
  validates :name, uniqueness: true
end
