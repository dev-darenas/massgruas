class CreateDocumentTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :document_types do |t|
      t.string :name
      t.references :enterprise, null: false, foreign_key: true

      t.timestamps
    end
  end
end
