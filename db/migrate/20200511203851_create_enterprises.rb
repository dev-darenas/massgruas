class CreateEnterprises < ActiveRecord::Migration[6.0]
  def change
    create_table :enterprises do |t|
      t.string :name
      t.integer :service_number, null: false, default: 1

      t.timestamps
    end
  end
end
