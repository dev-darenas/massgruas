class Document < ApplicationRecord
  belongs_to :document_type
  belongs_to :documentable, polymorphic: true
  has_many :pictures, as: :imageable
  accepts_nested_attributes_for :pictures,
                                reject_if: lambda {
                                    |a| a[:image].blank?
                                }, allow_destroy: true
  validates :document_type_id, uniqueness: { scope: :documentable_type }

end
