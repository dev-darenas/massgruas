class CreateObservations < ActiveRecord::Migration[6.0]
  def change
    create_table :observations do |t|
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.references :observable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
