class ActiveToVehicle < ActiveRecord::Migration[6.0]
  def change
    add_column :vehicles, :active, :boolean, default: true
  end
end
