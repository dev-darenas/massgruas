class Document < ApplicationRecord
  acts_as_paranoid
  belongs_to :document_type
  belongs_to :document_type_including_deleted, class_name: "DocumentType",
             foreign_key: 'document_type_id', with_deleted: true

  belongs_to :documentable, polymorphic: true
  has_many :pictures, as: :imageable
  accepts_nested_attributes_for :pictures,
                                reject_if: lambda {
                                    |a| a[:attachments].blank?
                                }, allow_destroy: true
  validates :document_type_id, uniqueness: { scope: [:documentable_type, :documentable_id ]}

end
