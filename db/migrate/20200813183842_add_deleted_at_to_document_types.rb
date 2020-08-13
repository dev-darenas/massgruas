class AddDeletedAtToDocumentTypes < ActiveRecord::Migration[6.0]
  def change
    add_column :document_types, :deleted_at, :datetime
    add_index :document_types, :deleted_at
  end
end
