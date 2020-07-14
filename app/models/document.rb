class Document < ApplicationRecord
  belongs_to :document_type
  belongs_to :documentable, polymorphic: true
  has_many :pictures, as: :imageable
end
