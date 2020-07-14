class CreateDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :documents do |t|
      t.references :document_type, null: false, foreign_key: true
      t.boolean :renewable
      t.references :documentable, polymorphic: true, null: false
      t.date :due_date

      t.timestamps
    end
  end
end
