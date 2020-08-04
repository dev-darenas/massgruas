class Document < ApplicationRecord
  belongs_to :document_type
  belongs_to :documentable, polymorphic: true
  has_many :pictures, as: :imageable
  validates :document_type_id, uniqueness: { scope: :documentable_type }

end
